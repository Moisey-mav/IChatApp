//
//  SetupProfileViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    private let welcomeLabel = UILabel(text: "Set up profile!", font: .avenir26())
    private let fullNameLabel = UILabel(text: "Full name")
    private let aboutMeLabel = UILabel(text: "About me")
    private let sexLabel = UILabel(text: "Sex")
    
    private let fullNameTextField = OneLineTextField(font: .avenir20())
    private let aboutMeTextField = OneLineTextField(font: .avenir20())
    
    private let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Femail")
    
    private let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    
    private let fillImageView = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        let fillNameStackView = UIStackView(arrangedSubvews: [fullNameLabel, fullNameTextField], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubvews: [aboutMeLabel, aboutMeTextField], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(arrangedSubvews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 12)
        
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubvews: [fillNameStackView, aboutMeStackView, sexStackView, goToChatsButton], axis: .vertical, spacing: 40)
        
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(fillImageView)
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let profileVC = SetupProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) -> UIViewController {
            return profileVC
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) {
            
        }
    }
}