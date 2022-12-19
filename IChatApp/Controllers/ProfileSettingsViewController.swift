//
//  ProfileSettingsViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 17.12.2022.
//

import UIKit
import FirebaseAuth
import Nuke
import NukeExtensions

class ProfileSettingsViewController: UIViewController {
    
    private var fullImageView = ProfilePhotoView()
    private let userNameLabel = UILabel(text: "User Name")
    private let loginOutButton = UIButton(title: "Login out", font: .laoSangamMN20(), titleColor: #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1), backgroundColor: .clear, cornerRadius: 10)
    
    private var tabelView: UITableView = {
        let tabel = UITableView(frame: .zero, style: .insetGrouped)
        tabel.backgroundColor = .clear
        tabel.separatorColor = .white
        tabel.isScrollEnabled = false
        return tabel
    }()
    
    private let containerView = UIView()
    
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.clipsToBounds = true
        let blurEffect = UIBlurEffect(style: .dark)
        view.effect = blurEffect
        return view
    }()
    
    var models = [TableSection]()
    
    private let currentUser: MUser

    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        userNameLabel.text = "\(currentUser.firstName) \(currentUser.secondName)"
        guard let url = URL(string: currentUser.avatarStringURL) else { return }
        loadImage(with: Nuke.ImageRequest(url: url),
                  options: ImageLoadingOptions(placeholder: UIImage(), transition: .fadeIn(duration: 0.5)),
                  into: fullImageView.circleImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupConstraint()
        customizeElement()
        setupTabelView()
        setupButton()
    }
    
    private func customizeElement() {
        containerView.layer.cornerRadius = 30
        containerView.backgroundColor = .navigationBarDark()
        containerView.layer.shadowColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowOffset = CGSize(width: 0, height: -6)
        
        containerView.applyViewGradient(cornerRadius: 30)
        
        userNameLabel.textAlignment = .center
        loginOutButton.layer.borderWidth = 1.2
        loginOutButton.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    private func setupTabelView() {
        setupPatterns()
        registerCell()
        configureCell()
    }
    
    private func setupButton() {
        loginOutButton.addTarget(self, action: #selector(loginOutButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginOutButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.keyWindow?.rootViewController = AuthViewController()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }))
        present(alertController, animated: true)
    }
    
    private func setupPatterns() {
        tabelView.delegate = self
        tabelView.dataSource = self
    }
    
    private func registerCell() {
        tabelView.register(ProfileSettingsCell.self, forCellReuseIdentifier: "ProfileSettingsCell")
    }
    
    private func configureCell() {
        models.append(TableSection(title: "", options: [
            .staticCell(model: StaticCellOptions(content: "Email: \(currentUser.email)", icon: UIImage(systemName: "envelope"), iconBackgroundColor: .gray)),
            .staticCell(model: StaticCellOptions(content: "ID: \(currentUser.id)", icon: UIImage(systemName: "grid"), iconBackgroundColor: .gray)),
            .staticCell(model: StaticCellOptions(content: "Sex: \(currentUser.sex)", icon: UIImage(systemName: "person.circle"), iconBackgroundColor: .gray)),
            .staticCell(model: StaticCellOptions(content: "Description: \(currentUser.description)", icon: UIImage(systemName: "person.text.rectangle"), iconBackgroundColor: .gray))
        ]))
    }
}

// MARK: - Setup Constraint
extension ProfileSettingsViewController {
    
    private func setupConstraint() {
        let stackView = UIStackView(arrangedSubvews: [fullImageView, userNameLabel], axis: .vertical, spacing: 10)
        
        view.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -200)
        ])
        
        view.addSubview(tabelView)
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            tabelView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            tabelView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            tabelView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
        ])
        
        view.addSubview(loginOutButton)
        loginOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginOutButton.topAnchor.constraint(equalTo: tabelView.bottomAnchor, constant: 10),
            loginOutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 35),
            loginOutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -35),
            loginOutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ProfileSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.identifier, for: indexPath) as? ProfileSettingsCell else {return UITableViewCell()}
            cell.backgroundColor = .clear
            cell.configureSettingCell(with: model)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ProfileSettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
