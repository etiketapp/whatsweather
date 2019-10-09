//
//  CorneredView.swift
//  Base
//
//  Created by Mehmet Salih Aslan on 12.01.2018.
//  Copyright © 2018 Mehmet Salih Aslan. All rights reserved.
//

import UIKit

@IBDesignable
class CorneredView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        awakeFromNib()
    }
    
}
