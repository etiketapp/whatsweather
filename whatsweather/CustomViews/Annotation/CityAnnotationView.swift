//
//  CityAnnotationView.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import MapKit

class CityAnnotationView: MKAnnotationView {
    
    @IBOutlet weak var pinImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
