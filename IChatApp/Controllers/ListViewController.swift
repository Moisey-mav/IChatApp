//
//  ListViewController.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    let activeChats = Bundle.main.decode([MChat].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([MChat].self, from: "waitingChats.json")
    
    enum Section: Int, CaseIterable {
        case waitingChats, activeChat
        
        func description() -> String {
            switch self {
            case .waitingChats:
                return "Waiting Chats"
            case .activeChat:
                return "Active Chats"
            }
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        creatingCollectionView()
        createDataSource()
        reloadData()
    }
    
    private func creatingCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.identifier)
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.identifier)
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MChat>()
        snapshot.appendSections([.waitingChats, .activeChat])
        snapshot.appendItems(activeChats, toSection: .activeChat)
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Data Source
extension ListViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            
            switch section {
            case .waitingChats:
                return self.configure(collectionView: collectionView, cellType: WaitingChatCell.self, with: chat, for: indexPath)
            case .activeChat:
                return self.configure(collectionView: collectionView, cellType: ActiveChatCell.self, with: chat, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unkniwn section kind") }
            sectionHeader.configure(text: section.description(), font: .laoSangamMN20(), textColor: .headerTextGray())
            return sectionHeader
        }
    }
}

// MARK: - Stup layout
extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection in
            guard let section = Section(rawValue: sectionIndex) else { fatalError("Unknown section kind") }
            switch section {
            case .waitingChats:
                return self.createWaitingChats()
            case .activeChat:
                return self.createActiveChats()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}

// MARK: - Search bar
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: - SwiftUI

import SwiftUI

struct ListViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListViewControllerProvider.ContainerView>) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ListViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListViewControllerProvider.ContainerView>) {
            
        }
    }
}
