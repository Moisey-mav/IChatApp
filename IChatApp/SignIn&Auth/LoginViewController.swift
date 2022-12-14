//
//  LoginViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let containerView = UIView(cornerRadius: 30, backgroundColor: .clear)
    
    private let blurView = UIVisualEffectView(cornerRadius: 15, blurStyle: .dark)
    
    private let welcomeLabel = UILabel(text: "Welcom back!", font: .avenir26())
    private let emailLabel = UILabel(text: "Email")
    private let passwordLabel = UILabel(text: "Password")
    private let needAnAccountLabel = UILabel(text: "Need an account?")

    private let emailTextField = OneLineTextField(font: .avenir20())
    private let passwordTextField = OneLineTextField(font: .avenir20(), isSecure: true)
    
    private let googleButton = UIButton(title: "Login with Google", font: .avenir15(), titleColor: .white, backgroundColor: .white)
    private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark())
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        customizeElement()
    }
    
    private func setupUI() {
        setupConstraint()
        customizeElement()
        setupButton()
    }
    
    private func customizeElement() {
        containerView.layer.cornerRadius = 30
        containerView.layer.shadowColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowOffset = CGSize(width: 0, height: -6)
        
        containerView.applyViewGradient(cornerRadius: 30)
        loginButton.applyButtonGradientBlue(cornerRadius: 15)
        
        emailLabel.textColor = .headerTextField()
        passwordLabel.textColor = .headerTextField()
        needAnAccountLabel.textColor = .headerTextField()
        welcomeLabel.textColor = .white
    }
    
    private func setupButton() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(
            email: emailTextField.text!,
            password: passwordTextField.text!) { (result) in
                switch result {
                case .success(let user):
                    self.showAlert(with: "Успешно!", and: "Вы авторизованы!") {
                        FirestoreService.shared.getUserData(user: user) { (result) in
                            switch result {
                            case .success(let muser):
                                let mainTabBar = MainTabBarController(currentUser: muser)
                                mainTabBar.modalPresentationStyle = .fullScreen
                                self.present(mainTabBar, animated: true, completion: nil)
                            case .failure(_):
                                self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                            }
                        }
                    }
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
    }
    
    @objc private func signUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
}

// MARK: - Setup Constraint
extension LoginViewController {
    
    private func setupConstraint() {
        let emailStackView = UIStackView(arrangedSubvews: [emailLabel, emailTextField], axis: .vertical, spacing: 5)
        let passwordStackView = UIStackView(arrangedSubvews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubvews: [emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 40)
      
        let bottomStackView = UIStackView(arrangedSubvews: [needAnAccountLabel, signUpButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        view.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -200)
        ])
        
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])
        
        containerView.addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])
    }
}
