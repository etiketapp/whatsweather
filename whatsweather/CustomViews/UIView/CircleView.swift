//
//  CircleView.swift
//  Base
//
//  Created by Mehmet Salih Aslan on 12.01.2018.
//  Copyright © 2018 Mehmet Salih Aslan. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width/2
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.cornerRadius = self.frame.size.width/2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
    }
    
}
