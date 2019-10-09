//
//  WeatherCVCell.swift
//  whatsweather
//
//  Created by tunay alver on 8.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import Lottie

class WeatherCVCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionView: CircleView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var weatherData: WeatherData! {
        didSet {
            if weatherData.isSelected ?? false {
                self.selectionView.isHidden = false
                self.selectionView.backgroundColor = Colors.mainGreen
            }else {
                self.selectionView.isHidden = true
            }
            
            titleLabel.text = weatherData.dateIt().to(.readableTime)
            let temp = weatherData.main.temp
            subtitleLabel.text = "\(temp?.toCelsius() ?? 0) °C"
            self.animate(name: weatherData.weather[0].main)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
//    let animation = Animation.named("weather-partly-cloudy")
    func animate(name: String?) {
        let animation = Animation.named(name ?? "Clouds")
        animationView.loopMode = .loop
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
    
}
