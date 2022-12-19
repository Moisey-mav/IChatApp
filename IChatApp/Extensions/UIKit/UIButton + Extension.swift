//
//  UIButton + Extension.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, font: UIFont? = .avenir20(), titleColor: UIColor, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 4, isShadowStyle: Bool = false) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadowStyle {
            self.layer.shadowColor = UIColor.red.cgColor
            self.layer.shadowRadius = 15
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
    
    func customizeGoogleButton() {
        let googleLogo = UIImageView(image: UIImage(named: "GoogleLogo"), contentMode: .scaleAspectFit)
        self.addSubview(googleLogo)
        googleLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            googleLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            googleLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            googleLogo.heightAnchor.constraint(equalToConstant: 35),
            googleLogo.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
