//
//  ProfileViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 09.12.2022.
//

import UIKit
import Nuke
import NukeExtensions

class ProfileViewController: UIViewController {
    
    private let containerView = UIView(cornerRadius: 30, backgroundColor: .clear)
    private let imageView = UIImageView(image: UIImage(named: "human1"), contentMode: .scaleAspectFill)
    private let nameLabel = UILabel(text: "Peter Ben", font: .systemFont(ofSize: 20, weight: .light))
    private let aboutMeLabel = UILabel(text: "You have the opportunity to chat with the best world!", font: .systemFont(ofSize: 16, weight: .light))
    private let myTextField = InsertableTextField()
    
    private let user: MUser
    
    init(user: MUser) {
        self.user = user
        self.nameLabel.text = "\(user.firstName) \(user.secondName)"
        self.aboutMeLabel.text = user.description
        let url = URL(string: user.avatarStringURL)
        loadImage(with: Nuke.ImageRequest(url: url),
                  options: ImageLoadingOptions(placeholder: UIImage(),
                  transition: .fadeIn(duration: 0.5)),
                  into: imageView, completion: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        customizeElement()
    }
    
    private func setupUI() {
        configureView()
        setupConstraint()
        setupButton()
    }
    
    private func configureView() {
        view.backgroundColor = .mainWhite()
    }
    
    private func customizeElement() {
        containerView.layer.shadowColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowOffset = CGSize(width: 0, height: -6)
        containerView.applyViewGradient(cornerRadius: 30)
        
        aboutMeLabel.numberOfLines = 0
        myTextField.borderStyle = .roundedRect
    }
    
    private func setupButton() {
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    @objc private func sendMessage() {
        guard let message = myTextField.text, message != "" else { return }
        
        self.dismiss(animated: true) {
            FirestoreService.shared.createWaitingChat(message: message, receiver: self.user) { (result) in
                switch result {
                case .success():
                    UIApplication.shared.keyWindow?.rootViewController?.showAlert(with: "Успешно!", and: "ваше сообщение для \(self.user.firstName) было отправленно.")
                case .failure(let error):
                    UIApplication.shared.keyWindow?.rootViewController?.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Setup Constraint
extension ProfileViewController {
    private func setupConstraint() {
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMeLabel)
        containerView.addSubview(myTextField)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            myTextField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
            myTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            myTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            myTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
