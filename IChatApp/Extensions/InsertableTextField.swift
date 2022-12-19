//
//  InsertableTextField.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 09.12.2022.
//

import UIKit

class InsertableTextField: UITextField {
    
    private let messageIcon: UIImageView = {
        let imageView =  UIImageView(image: UIImage(systemName: "face.smiling"))
        imageView.setupColor(color: .lightGray)
        return imageView
    }()
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Sent"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        customizedTextField()
        setupConstraint()
    }
    
    private func customizedTextField() {
        backgroundColor = .clear
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: "White something here ...",
                                                   attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.608915627, green: 0.6034373641, blue: 0.6296523213, alpha: 1)])
        font = UIFont.systemFont(ofSize: 14)
        clearButtonMode = .whileEditing
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.608915627, green: 0.6034373641, blue: 0.6296523213, alpha: 1)
        layer.cornerRadius = 18
        layer.masksToBounds = true
    }
    
    private func setupConstraint() {
        leftView = messageIcon
        leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        leftViewMode = .always
        
        rightView = messageButton
        rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsertableTextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -12
        return rect
    }
    
}
