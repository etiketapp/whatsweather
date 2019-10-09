//
//  AppButton.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

@IBDesignable
class AppButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.alpha = 0.5
            }else {
                self.alpha = 1.0
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.alpha = 1.0
            }else {
                self.alpha = 0.5
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        awakeFromNib()
    }
    
}
