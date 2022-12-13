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
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupConstraint()
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        guard let url = URL(string: chat.friendAvatarStringURL) else { return }
        let nukeRequest = Nuke.ImageRequest(url: url)
        let options = ImageLoadingOptions(placeholder: UIImage(), transition: .fadeIn(duration: 0.5))
        loadImage(with: nukeRequest, options: options, into: friendImageView, completion: nil)
    }
    
    private func configureCell() {
        backgroundColor = .yellow
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    private func setupConstraint() {
        addSubview(friendImageView)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
