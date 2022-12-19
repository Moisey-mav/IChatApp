//
//  MainTabBarController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
    
    init(currentUser: MUser = MUser(firstName: "UU", secondName: "TT", email: "EE", avatarStringURL: "AA", description: "DD", sex: "SS", id: "II")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeHeightOfTabbar()
    }
    
    private func settingsTabBar() {
        setupVC()
        settingsCustomTabBar()
    }
     
    private func setupVC() {
        
        let listVC = ListViewController(currentUser: currentUser)
        let peopleVC = PeopleViewController(currentUser: currentUser)
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)
        
        viewControllers = [ generateNavigationController(rootViewController: peopleVC, title: "People", image: peopleImage),
                            generateNavigationController(rootViewController: listVC, title: "Conversation", image: convImage)]
    }
    
    private func settingsCustomTabBar() {
        // color title/image
        self.tabBar.tintColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        self.tabBar.backgroundColor = .navigationBarDark()
        self.tabBar.alpha = 1
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = true
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = #colorLiteral(red: 0.2418880761, green: 0.4674277306, blue: 0.9161326885, alpha: 1)
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.3765693307, green: 0.3765693307, blue: 0.3765693307, alpha: 1)
        self.tabBar.itemPositioning = .centered
    }
    
    private func changeHeightOfTabbar() {
        var tabFrame = tabBar.frame
        let sizeTabBar = view.frame.size.height / 9
        tabFrame.size.height = sizeTabBar
        tabFrame.origin.y = view.frame.size.height - sizeTabBar
        tabBar.frame = tabFrame
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.simleAnimationWhenSelectetItem(item)
    }
    
    private func simleAnimationWhenSelectetItem(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let itemInterval: TimeInterval = 0.3
        let propertyAnimation = UIViewPropertyAnimator(duration: itemInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }
        propertyAnimation.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(itemInterval))
        propertyAnimation.startAnimation()
    }
}
