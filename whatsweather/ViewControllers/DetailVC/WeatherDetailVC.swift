//
//  WeatherDetailVC.swift
//  whatsweather
//
//  Created by tunay alver on 3.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    //MARK: - Header
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    
    //MARK: - Bottom
    @IBOutlet weak var bottomPressureLabel: UILabel!
    @IBOutlet weak var bottomMoistureLabel: UILabel!
    @IBOutlet weak var bottomHeatMaxLabel: UILabel!
    @IBOutlet weak var bottomHeatMinabel: UILabel!
    @IBOutlet weak var bottomWindSpeedLabel: UILabel!
    @IBOutlet weak var bottomWindAngleLabel: UILabel!
    
    var isAnimated = false
    @IBOutlet weak var collectionView: UICollectionView!
    var dataIndex: Int? {
        didSet {
            weatherDatas?[dataIndex ?? 0].isSelected = true
            prepareViews(dataIndex: dataIndex ?? 0)
        }
    }
    var weatherDatas: [WeatherData]!
    var city: City!

    override func viewDidLoad() {
        super.viewDidLoad()
        preparevc()
        dataIndex = 0
    }
    
    //MARK: - Preparevc
    func preparevc() {
        setNavigationBarBackButtonEmpty()
        view.backgroundColor = .white
        collectionView.register(WeatherCVCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //NOTE: - To change navigation apperance but could not debug it for better work.
        self.navigationController?.changeNavigationBarStyle(color: Colors.mainGreen)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //NOTE: - To change navigation apperance but could not debug it for better work.
        self.navigationController?.changeNavigationBarStyle(color: .white)
    }
    
    //MARK: - Fill
    func prepareViews(dataIndex: Int) {
        if let name = city.name, let country = city.country {
            cityLabel.text = "\(String(name)) / \(String(country))"
        }else {
            cityLabel.text = ""
        }
        
        tempLabel.text = "\(weatherDatas[dataIndex].main.temp.toCelsius()) °C"
        weatherLabel.text = weatherDatas[dataIndex].weather[0].main
        expLabel.text = weatherDatas[dataIndex].weather[0].description
        
        bottomPressureLabel.text = String(weatherDatas[dataIndex].main.pressure)
        bottomMoistureLabel.text = String(weatherDatas[dataIndex].main.humidity)
        bottomHeatMaxLabel.text = "\(String(weatherDatas[dataIndex].main.temp_max.toCelsius())) °C"
        bottomHeatMinabel.text = "\(String(weatherDatas[dataIndex].main.temp_min.toCelsius())) °C"
        bottomWindSpeedLabel.text = String(weatherDatas[dataIndex].wind.speed)
        bottomWindAngleLabel.text = String(weatherDatas[dataIndex].wind.deg)
    }
    
}

extension WeatherDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDatas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherCVCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.weatherData = weatherDatas?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = height * 0.73
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.animateCellsToLeft(isAnimated: isAnimated, cell: cell, row: indexPath.row) {
            self.isAnimated = true
        }
    }
    
    
    //MARK : - Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? WeatherCVCell) != nil {
            for data in weatherDatas {
                data.isSelected = false
            }
            self.dataIndex = indexPath.row
            self.weatherDatas[indexPath.row].isSelected = true
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
}
