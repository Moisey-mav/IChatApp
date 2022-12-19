//
//  UIView + Extension.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 09.12.2022.
//

import UIKit

extension UIView {
    
    func applyButtonGradientBlue(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1), endColor: #colorLiteral(red: 0.113606371, green: 0.2567458153, blue: 0.5360535979, alpha: 1))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CALayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func applyGoogleButtonGradient(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.4268561602, green: 0.6881574988, blue: 1, alpha: 1), endColor: #colorLiteral(red: 0.2708942294, green: 0.5348944664, blue: 1, alpha: 1))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CALayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func applyViewGradient(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.2173863649, green: 0.2103277147, blue: 0.2966439724, alpha: 1), endColor: #colorLiteral(red: 0.1471860409, green: 0.1362504065, blue: 0.183981508, alpha: 1))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CALayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
