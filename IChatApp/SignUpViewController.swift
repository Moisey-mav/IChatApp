//
//  SignUpViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26())
    private let emailLabel = UILabel(text: "Email")
    private let passwprdLabel = UILabel(text: "Password")
    private let confirmPasswordLabel = UILabel(text: "Confirm password")
    private let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    private let emailTextField = OneLineTextField(font: .avenir20())
    private let passwprdTextField = OneLineTextField(font: .avenir20())
    private let confirmPasswordTextField = OneLineTextField(font: .avenir20())
    
    private let signUpButton = UIButton(title: "Sing Up", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupConstraint()
    }
    
    private func setupConstraint() {
        let emailStackView = UIStackView(arrangedSubvews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubvews: [passwprdLabel, passwprdTextField], axis: .vertical, spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubvews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubvews: [emailStackView, passwordStackView, confirmPasswordStackView, signUpButton], axis: .vertical, spacing: 40)
        let bottomStackView = UIStackView(arrangedSubvews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 10)
       
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.alignment = .firstBaseline
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let signUpVC = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpViewControllerProvider.ContainerView>) -> UIViewController {
            return signUpVC
        }
        
        func updateUIViewController(_ uiViewController: SignUpViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpViewControllerProvider.ContainerView>) {
            
        }
    }
}
