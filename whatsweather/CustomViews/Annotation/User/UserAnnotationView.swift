//
//  UserAnnotationView.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import MapKit
import Lottie

class UserAnnotationView: MKAnnotationView {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setup() {
        animationView.layer.cornerRadius = 12
        imageView.layer.cornerRadius = 8
        self.layer.cornerRadius = 12
    }
    
    func animate() {
        let animation = Animation.named("animationPin")
        animationView.loopMode = .loop
        animationView.animation = animation
        animationView.play()
    }
    
}
