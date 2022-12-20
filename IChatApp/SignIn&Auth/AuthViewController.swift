//
//  AuthViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private let blurView = UIVisualEffectView(cornerRadius: 15, blurStyle: .dark)
    
    private let logoImageView = UIImageView(image: UIImage(named: "AppLogo"), contentMode: .scaleAspectFit)
    
    private let emailLabel = UILabel(text: "Need an account?")
    private let loginLabel = UILabel(text: "Already onboard?")
    
    private let loginButton = UIButton(title: "Login", titleColor: .white)
    private let emailButton = UIButton(title: "Sing Up", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 15, isShadowStyle: true)
    
    
    private let signUpVC = SignUpViewController()
    private let loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupConstraints()
        setupButton()
        emailButton.clipsToBounds = true
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        customizeElement()
    }
    
    private func customizeElement() {
        emailLabel.textColor = .headerTextField()
        loginLabel.textColor = .headerTextField()
        
        loginButton.applyButtonGradientBlue(cornerRadius: 15)
        view.applyViewGradient(cornerRadius: 0)
    }
    
    private func setupButton() {
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpVC.delegate = self
        loginVC.delegate = self
    }
    
    @objc private func emailButtonTapped() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        present(loginVC, animated: true, completion: nil)
    }
}

// MARK: - Setup Constraints
extension AuthViewController {
    private func setupConstraints() {
        let emailView = ButtonFromView(label: emailLabel, button: emailButton)
        let loginView = ButtonFromView(label: loginLabel, button: loginButton)
        let stackView = UIStackView(arrangedSubvews: [loginView, emailView], axis: .vertical, spacing: 30)
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 300),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension AuthViewController: AuthNavigationDelegate {
    func toLoginVC() {
        present(loginVC, animated: true)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true)
    }
}
