//
//  WeatherLocationVC.swift
//  whatsweather
//
//  Created by tunay alver on 3.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import MapKit
import Lottie

class WeatherLocationVC: BaseVC {
    
    //UI
    var isSpanned = false
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: AppButton!
    //Cities
    var cities = [City(name: "Çanakkale", coord: Location(lat: 40.15, lon: 26.40)),
                  City(name: "Bursa", coord: Location(lat: 40.18, lon: 29.06)),
                  City(name: "Tekirdağ", coord: Location(lat: 40.97, lon: 27.51))]
    
    //Location
    let locationManager = CLLocationManager()
    var shouldAskPermission: Bool?
    var hasPermission: Bool!
    
    var userLocation: Location?
    var locationName = String()
    
    var city: City?
    var weatherDatas: [WeatherData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        checkLocationPermission()
        setCityLocations()
    }
    
    //MARK: - Web Function
    func getWeather(lat: Double, lon: Double) {
        self.startProgressHud()
        let request = HourlyRequest(lat: lat, lon: lon)
        request.request(success: { (response) in
            self.stopProgressHud()
            self.weatherDatas = response.list
            self.city = response.city
        }) { (error) in
            self.stopProgressHud()
            self.showErrorAlert(message: error.message)
        }
    }
    
    //MARK: - Location Permission
    func checkLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            shouldAskPermission = true
            hasPermission = false
            findUserLocation()
        case .restricted, .denied:
            shouldAskPermission = true
            hasPermission = false
            askPermission(shouldAsk: true)
        case .authorizedWhenInUse, .authorizedAlways:
            shouldAskPermission = false
            hasPermission = true
        @unknown default:
            self.showErrorAlert(message: "Beklenmedik bir hata oluştu.")
        }
    }
    
    func askPermission(shouldAsk: Bool?) {
        guard shouldAsk != nil && shouldAsk != false else { return }
        self.performAlertDoubleCompletionNDP(title: "Konum izini", message: "Size en yakın diyetisyenleri listeyebilmemiz için konumun izni vermelisiniz.", buttonTitle: "İzin Verme", button2Title: "Ayarlar", style: .alert, buttonTapped: {
            self.showErrorAlert(message: "Hava durumunu görmek için konuma izin vermelisiniz.")
        }) {
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
    }
    
    //MARK: - Action
    @IBAction func locationButtonTapped() {
        findUserLocation()
    }

}

//MARK: - Location
extension WeatherLocationVC: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func findUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Pin View
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation { //NOTE: - The location after didUpdate.
            
            //City Locations
        }else if annotation is CityAnnotation {
            let cityAnnotation = annotation as! CityAnnotation
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: Singleton.shared.pinIdentifier) as? CityAnnotationView
            pinView = CityAnnotationView().loadNib() as? CityAnnotationView
            cityAnnotation.title = "\(String(cityAnnotation.city.name)) 35°C"
            pinView?.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "appLogo30"))
            if pinView == nil {
                pinView = CityAnnotationView(annotation: annotation, reuseIdentifier: Singleton.shared.pinIdentifier)
                pinView?.canShowCallout = true
            }
            pinView?.canShowCallout = true
            return pinView
            //User Location
        }else if annotation is UserAnnotation {
            
            let userAnnotation = annotation as! UserAnnotation
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: Singleton.shared.pinIdentifier) as? UserAnnotationView
            pinView = UserAnnotationView().loadNib() as? UserAnnotationView
            
            if pinView == nil {
                pinView = UserAnnotationView(annotation: annotation, reuseIdentifier: Singleton.shared.pinIdentifier)
                pinView?.canShowCallout = false
                pinView?.image = userAnnotation.image
            }
            
            pinView?.animate()
            return pinView
        }
        
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        userLocation = Location()
        userLocation?.lat = location.latitude
        userLocation?.lon = location.longitude
        setUserLocation()
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        let loc = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            if error == nil {
                let placemark = placemarks?.first
                self.searchBar.text = placemark?.locality
                self.locationName = (placemark?.locality)!
            }else{
                self.showErrorAlert(message: error?.localizedDescription ?? "Beklenmedik bir hata oluştu.")
            }
        })
        
        //Note: - For found location span
        if isSpanned {
            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: span)
            mapView.setRegion(region, animated: true)
        }
        getWeather(lat: location.latitude, lon: location.longitude)
    }
    
    //MARK: - Set locations
    func setUserLocation() {
        if userLocation?.lat != nil && userLocation?.lon != nil {
            self.removeUserAnnotation()
            let latitude = userLocation?.lat!
            let longitude = userLocation?.lon!
            
            let myAnnotation: UserAnnotation = UserAnnotation()
            myAnnotation.location = userLocation
            myAnnotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
            
            mapView.addAnnotation(myAnnotation)
        }
    }
    
    func setCityLocations() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        for city in cities {
            guard city.coord != nil else { return }
            let latitude = city.coord.lat!
            let longitude = city.coord.lon!
            
            let myAnnotation: CityAnnotation = CityAnnotation()
            myAnnotation.city = city
            
            myAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            mapView.addAnnotation(myAnnotation)
        }
    }
    
    //MARK: - Remove Annotation
    func removeUserAnnotation() {
        for annotation in self.mapView.annotations {
            if annotation is UserAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
        }
    }
    
    //MARK: Span
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if !isSpanned {
            spanMap()
            isSpanned = true
        }
    }
    
    func spanMap() {
        let distance: Double
        var fittedRegion: MKCoordinateRegion
        if userLocation != nil {
            let currentLocation = CLLocation(latitude: (userLocation?.lat!)!, longitude: (userLocation?.lon!)!)
            let cityLocation = CLLocation(latitude: (cities[0].coord.lat)!, longitude: (cities[0].coord.lon)!)
            distance = currentLocation.distance(from: cityLocation)
            fittedRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: distance * 2, longitudinalMeters: distance * 2)
        }else {
            let firstLocation = CLLocation(latitude: (cities[0].coord.lat)!, longitude: (cities[0].coord.lon)!)
            let secondLocation = CLLocation(latitude: (cities[1].coord.lat)!, longitude: (cities[1].coord.lon)!)
            distance = firstLocation.distance(from: secondLocation)
            fittedRegion = MKCoordinateRegion(center: firstLocation.coordinate, latitudinalMeters: distance * 2, longitudinalMeters: distance * 2)
        }
        
        fittedRegion = mapView.regionThatFits(fittedRegion)
        fittedRegion.span.latitudeDelta *= 1.2
        fittedRegion.span.longitudeDelta *= 1.2
        mapView.setRegion(fittedRegion, animated: true)
    }
    
    //MARK: - Did Select
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.detailCalloutAccessoryView = UIView()
        if ((view.annotation as? UserAnnotation) != nil) {
            mapView.deselectAnnotation(view.annotation, animated: false)
            if self.weatherDatas != nil && self.city != nil {
                self.performSegue(withIdentifier: WeatherDetailVC.identifier, sender: nil)
            }else {
                self.performAlertDoubleCompletionNDP(title: "Hata", message: "Beklenmedik bir hata oluştu.", buttonTitle: "Tekrar Yükle", button2Title: "Vazgeç", style: .alert, buttonTapped: {
                    self.findUserLocation()
                }) {
                    //Cancel
                }
            }
        }
    }
    
    //MARK: - Permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            shouldAskPermission = true
            hasPermission = false
            break
        case .denied:
            shouldAskPermission = false
            hasPermission = false
            break
        case .authorizedWhenInUse:
            hasPermission = true
        case .authorizedAlways:
            hasPermission = true
        default:
            hasPermission = false
        }
        findUserLocation()
    }
}

//MARK: - SearchBar
extension WeatherLocationVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchBar.text!) { (placemarks, error) in
            if error == nil {
                let placemark = placemarks?.first
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location?.coordinate)!
                annotation.title = searchBar.text

                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)

                self.mapView.setRegion(region, animated: true)

                var loc = CLLocationCoordinate2D()
                let getLat: CLLocationDegrees = annotation.coordinate.latitude
                let getLon: CLLocationDegrees = annotation.coordinate.longitude
                loc.latitude = getLat
                loc.longitude = getLon

                self.locationName = (placemark?.locality ?? "No name found.")
                self.userLocation?.lon = loc.longitude
                self.userLocation?.lat = loc.latitude
                self.getWeather(lat: loc.latitude, lon: loc.longitude)
                self.setUserLocation()
            }else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Beklenmedik bir hata oluştu.")
            }
        }
    }
}

//MARK: - Prepare
extension WeatherLocationVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeatherDetailVC {
            destination.weatherDatas = self.weatherDatas
            destination.city = self.city
        }
    }
}
