//
//  FavoriteCitiesViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import UIKit
import Combine
import os.log

protocol FavoriteCitiesViewControllerDelegate: AnyObject {
    func controllerDidRefresh(_ controller: ForecastViewController)
}

class FavoriteCitiesViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Location>!
    private var chosenCityCancellable: AnyCancellable?
    
    @IBOutlet var favoriteCitiesCollection: UICollectionView! {
        didSet {
            // Create Collection View Layout
            favoriteCitiesCollection.collectionViewLayout = configureLayout()
        }
    }
    // MARK: -
    
    var favorites = UserDefaults.locations
     
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForTheme()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        setupViewModel(with: favorites)
    }
    
    // MARK: - View Methods
    private func setupViewModel(with favorites: [Location]) {
        configureDataSource()
        reloadData(location: favorites)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateColor()
    }
    
    @objc private func addCityTapped() {
        let addCityVC = AddCityViewController()
        let addCityNav = UINavigationController(rootViewController: addCityVC)
        present(addCityNav, animated: true, completion: nil)
        
        chosenCityCancellable = addCityVC.$chosenCity
            .dropFirst()
            .sink { city in
                addCityNav.dismiss(animated: true, completion: nil)
                
                if let city = city {
                    // Update User Defaults
                    UserDefaults.addLocation(city)
                    // Update favorites Locations
                    self.favorites.append(city)
                    // reload
                    self.reloadData(location: self.favorites)
                }
            }
    }
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// swiftlint:disable notification_center_detachment
// swiftlint:disable explicit_init
extension FavoriteCitiesViewController: ThemeableColor {
    func registerForTheme() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(colorChanged), name: NSNotification.Name.init("ColorChanged"),
            object: nil)
    }
    
    func unregisterForTheme() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func colorChanged() {
        animateColor()
    }
    
    func animateColor() {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
            self.favoriteCitiesCollection.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        }
    }
}

extension FavoriteCitiesViewController {
    // Configure Collection View Layout
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let cityItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5)))
        cityItem.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130)), subitems: [cityItem])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // Configure Cell
    private func configure<T: SelfConfiguringCityCell  & ReusableView >(_ cellType: T.Type, with location: Location, for indexPath: IndexPath) -> T {
        guard let cell = favoriteCitiesCollection.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            Logger.network.error("Unable to dequeue \(cellType)")
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: location)
        return cell
    }
    
    // Configure Collection Data Source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Location>(collectionView: favoriteCitiesCollection) { _, indexPath, location -> UICollectionViewCell? in
            self.configure(CityCell.self, with: location, for: indexPath)
        }
    }
    
    // load snapshot of Data
    private func reloadData(location: [Location]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        snapshot.appendSections([.main])
        snapshot.appendItems(location, toSection: .main)
        dataSource.apply(snapshot)
    }
}

extension FavoriteCitiesViewController {
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let menu = contextMenu(for: indexPath.row)
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            menu
        })
    }
    
    func contextMenu(for index: Int) -> UIMenu {
        let city = favorites[index]
        let action = UIAction(title: "Delete City", attributes: [.destructive]) { [weak self] _ in
            // Update User Defaults
            UserDefaults.removeLocation(city)
            self?.favorites.remove(at: index)
            // reload
            self?.reloadData(location: self!.favorites)
        }
        
        let menu = UIMenu(title: city.name, options: [], children: [action])
        return menu
    }
}
