//
//  ActiveChatCell.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import UIKit
import Nuke
import NukeExtensions

class ActiveChatCell: UICollectionViewCell, SelfConfigureCell {
   
    static var identifier = "ActiveChatCell"
    
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User name", font: .laoSangamMN20())
    let lastMessage = UILabel(text: "Hello", font: .laoSangamMN18())
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1), endColor: #colorLiteral(red: 0.113606371, green: 0.2567458153, blue: 0.5360535979, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupConstraint()
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        guard let url = URL(string: chat.friendAvatarStringURL) else { return }
        friendName.text = "\(chat.friendFirstName) \(chat.frientSecondName)"
        lastMessage.text = chat.lastMessageContent
        loadImage(with: Nuke.ImageRequest(url: url),
                  options: ImageLoadingOptions(placeholder: UIImage(), transition: .fadeIn(duration: 0.5)),
                  into: friendImageView, completion: nil)
    }
    
    private func configureCell() {
        backgroundColor = #colorLiteral(red: 0.1550748348, green: 0.1440279186, blue: 0.1960613728, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension ActiveChatCell {
    private func setupConstraint() {
        addSubview(friendImageView)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendImageView.backgroundColor = .orange
        NSLayoutConstraint.activate([
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 78),
            friendImageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.backgroundColor = .black
        NSLayoutConstraint.activate([
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
            gradientView.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        addSubview(friendName)
        friendName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            friendName.leadingAnchor.constraint(equalTo: self.friendImageView.trailingAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
        
        addSubview(lastMessage)
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            lastMessage.leadingAnchor.constraint(equalTo: self.friendImageView.trailingAnchor, constant: 16),
            lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct ActiveChatProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ActiveChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) {
            
        }
    }
}
