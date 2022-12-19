//
//  WaitingChatCell.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import UIKit
import Nuke
import NukeExtensions

class WaitingChatCell: UICollectionViewCell, SelfConfigureCell {
    
    static var identifier = "WaitingChatCell"
    
    private let friendImageView = UIImageView()
    private let userName = UILabel(text: "text", font: .laoSangamMN10())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupConstraint()
        customizeElement()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        friendImageView.layer.masksToBounds = true
        friendImageView.layer.cornerRadius = friendImageView.frame.width / 2
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        guard let url = URL(string: chat.friendAvatarStringURL) else { return }
        let nukeRequest = Nuke.ImageRequest(url: url)
        let options = ImageLoadingOptions(placeholder: UIImage(), transition: .fadeIn(duration: 0.5))
        loadImage(with: nukeRequest, options: options, into: friendImageView, completion: nil)
        userName.text = chat.friendFirstName
    }
    
    private func configureCell() {
        backgroundColor = .clear
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    private func customizeElement() {
        friendImageView.layer.borderWidth = 1
        friendImageView.layer.borderColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        userName.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraint
extension WaitingChatCell {
    private func setupConstraint() {
        addSubview(friendImageView)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            friendImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            friendImageView.heightAnchor.constraint(equalTo: self.widthAnchor)
           
        ])
        addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: friendImageView.bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            userName.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI
import NukeExtensions

struct WaitingChatProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<WaitingChatProvider.ContainerView>) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: WaitingChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WaitingChatProvider.ContainerView>) {
            
        }
    }
}
