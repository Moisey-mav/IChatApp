//
//  UIVisualEffectView + Extension.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 20.12.2022.
//

import UIKit

extension UIVisualEffectView {
    
    convenience init(cornerRadius: CGFloat, blurStyle: UIBlurEffect.Style) {
        self.init()
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        let blurEffect = UIBlurEffect(style: .dark)
        self.effect = blurEffect
    }
}
