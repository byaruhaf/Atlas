//
//  ForecastViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

protocol ForecastViewControllerDelegate: AnyObject {
    func controllerDidRefresh(_ controller: ForecastViewController)
}

final class ForecastViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ForecastDayViewModel>!
    
    // MARK: - Properties
    
    weak var delegate: ForecastViewControllerDelegate?
    
    @IBOutlet var forecastListCollection: UICollectionView! {
        didSet {
            // Create Collection View Layout
            forecastListCollection.collectionViewLayout = configureLayout()
            // Register day Collection View Cell
            let forecastListCollectionCellxib = UINib(nibName: ForecastListCollectionViewCell.nibName, bundle: .main)
            forecastListCollection.register(forecastListCollectionCellxib, forCellWithReuseIdentifier: ForecastListCollectionViewCell.reuseIdentifier)
            // Set Refresh Control
            forecastListCollection.refreshControl = refreshControl
        }
    }
    
    // MARK: -
    
    var viewModel: ForecastViewModel? {
        didSet {
            refreshControl.endRefreshing()
            // updateView()
            guard let viewModel else { return }
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: -
    
    private lazy var refreshControl: UIRefreshControl = {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: - View Methods
    private func setupViewModel(with viewModel: ForecastViewModel) {
        configureDataSource()
        reloadData(forecastDayViewModel: viewModel.generateForecastDayViewModel(from: viewModel.weatherData))
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
    
    // MARK: - Actions
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        delegate?.controllerDidRefresh(self)
        refreshControl.endRefreshing()
    }
    
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// MARK: - Data Source
extension ForecastViewController {
    // Configure Cell
    func configure<T: SelfConfiguringCell  & ReusableView >(_ cellType: T.Type, with forecastDayViewModel: any WeekDayRepresentable, for indexPath: IndexPath) -> T {
        guard let cell = forecastListCollection.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: forecastDayViewModel)
        return cell
    }
    
    // Configure Collection Data Source
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ForecastDayViewModel>(collectionView: forecastListCollection) { _, indexPath, forecastDayViewModel -> UICollectionViewCell? in
            self.configure(ForecastListCollectionViewCell.self, with: forecastDayViewModel, for: indexPath)
        }
    }
    
    // load snapshot of Data
    func reloadData(forecastDayViewModel: [ForecastDayViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ForecastDayViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(forecastDayViewModel, toSection: .main)
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
