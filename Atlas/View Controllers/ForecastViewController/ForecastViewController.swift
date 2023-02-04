//
//  ForecastViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class ForecastViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, WeatherDayData>!
    
    @IBOutlet var forecastListCollection: UICollectionView! {
        didSet {
            // Create Collection View Layout
            forecastListCollection.collectionViewLayout = configureLayout()
            // Register day Collection View Cell
            let forecastListCollectionCellxib = UINib(nibName: ForecastListCollectionViewCell.nibName, bundle: .main)
            forecastListCollection.register(forecastListCollectionCellxib, forCellWithReuseIdentifier: ForecastListCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: -
    
    var viewModel: ForecastViewModel? {
        didSet {
            // updateView()
            guard let viewModel = viewModel else {
                return
            }
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: - View Methods
    private func setupViewModel(with viewModel: ForecastViewModel) {
//        print(viewModel.weeksDayWeatherData)
        configureDataSource()
        reloadData(weatherDayData: viewModel.weeksDayWeatherData)
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register for Observer
        registerForTheme()
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
    }
    
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// MARK: - Data Source
extension ForecastViewController {
    // Configure Cell
    func configure<T: SelfConfiguringCell  & ReusableView >(_ cellType: T.Type, with weatherDayData: WeatherDayData, for indexPath: IndexPath) -> T {
        guard let cell = forecastListCollection.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: weatherDayData)
        return cell
    }
    
    // Configure Collection Data Source
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, WeatherDayData>(collectionView: forecastListCollection) { _, indexPath, weatherDayData -> UICollectionViewCell? in
            self.configure(ForecastListCollectionViewCell.self, with: weatherDayData, for: indexPath)
        }
    }
    
    // load snapshot of Data
    func reloadData(weatherDayData: [WeatherDayData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherDayData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(weatherDayData, toSection: .main)
        dataSource.apply(snapshot)
    }
}

// MARK: - Layout
extension ForecastViewController {
    // Configure Collection View Layout
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        return listLayout
    }
}

// swiftlint:disable notification_center_detachment
// swiftlint:disable explicit_init
extension ForecastViewController: ThemeableColor {
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
        }
    }
}
