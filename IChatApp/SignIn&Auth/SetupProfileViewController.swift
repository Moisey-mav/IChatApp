//
//  SetupProfileViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 07.12.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class SetupProfileViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .backgroundViewDark()
        return view
    }()
    
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.clipsToBounds = true
        let blurEffect = UIBlurEffect(style: .dark)
        view.effect = blurEffect
        return view
    }()
    
    private let welcomeLabel = UILabel(text: "Set up profile!", font: .avenir26())
    private let firstNameLabel = UILabel(text: "First name *")
    private let secondNameLabel = UILabel(text: "Second name *")
    private let aboutMeLabel = UILabel(text: "About me *")
    private let sexLabel = UILabel(text: "Sex *")
    
    private let firstNameTextField = OneLineTextField(font: .avenir20())
    private let secondNameTextField = OneLineTextField(font: .avenir20())
    private let aboutMeTextField = OneLineTextField(font: .avenir20())
    
    private let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Femail")
    
    private let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .clear, cornerRadius: 4)
    
    private let fullImageView = AddPhotoView()
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
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
        setColorObject()
    }
    
    private func setupUI() {
        setupConstraints()
        setupButton()
    }
    
    private func setColorObject() {
        containerView.layer.cornerRadius = 30
        containerView.layer.shadowColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowOffset = CGSize(width: 0, height: -6)
        
        containerView.applyViewGradient(cornerRadius: 30)
        goToChatsButton.applyButtonGradientBlue(cornerRadius: 15)
        view.applyViewGradient(cornerRadius: 0)
        
        firstNameLabel.textColor = .headerTextField()
        secondNameLabel.textColor = .headerTextField()
        aboutMeLabel.textColor = .headerTextField()
        sexLabel.textColor = .headerTextField()
        

    }
    
    private func setupButton() {
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func goToChatsButtonTapped() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid, email: currentUser.email!, firstName: firstNameTextField.text, secondName: secondNameTextField.text, avatarImage: fullImageView.circleImageView.image, description: aboutMeTextField.text, sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { (result) in
                switch result {
                case .success(let muser):
                    self.showAlert(with: "Успешно!", and: "Данные сохранены!", completion: {
                        let mainTabBar = MainTabBarController(currentUser: muser)
                        mainTabBar.modalPresentationStyle = .fullScreen
                        self.present(mainTabBar, animated: true, completion: nil)
                    })
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                    print(error.localizedDescription)
                }
        }
    }
    
    @objc func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
}

// MARK: - Setup Constraint

extension SetupProfileViewController {
    
    private func setupConstraints() {
        let firstNameStackView = UIStackView(arrangedSubvews: [firstNameLabel, firstNameTextField], axis: .vertical, spacing: 0)
        let secondNameStackView = UIStackView(arrangedSubvews: [secondNameLabel, secondNameTextField], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubvews: [aboutMeLabel, aboutMeTextField], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(arrangedSubvews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 12)
        
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubvews: [firstNameStackView, secondNameStackView, aboutMeStackView, sexStackView, goToChatsButton], axis: .vertical, spacing: 20)
        
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
        
        containerView.addSubview(fullImageView)
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleImageView.image = image
    }
}

