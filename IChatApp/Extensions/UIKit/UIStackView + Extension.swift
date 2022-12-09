//
//  UIStackView + Extension.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubvews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubvews)
        self.axis = axis
        self.spacing = spacing
    }
    
}
