//
//  AddCityViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import UIKit
import Combine
import os.log

class AddCityViewController: UITableViewController {
    
    enum Section: Int {
        case results
    }
    
    private let viewModel = AddCityViewModel()
    
    @Published
    private(set) var chosenCity: Location?
    
    struct Result: Identifiable, Equatable, Hashable {
        let id = UUID()
        let title: String
        let subtitle: String
    }
    
    private var diffableDatasource: UITableViewDiffableDataSource<Section, Result>!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .done, target: self, action: #selector(dismissSearch))
        navigationItem.title = "Add City"
        
        configureTableView()
        configureSearch()
        
        viewModel.$showSpinner
            .sink { [unowned self] in
                if $0 {
                    let indicator = UIActivityIndicatorView()
                    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
                    indicator.startAnimating()
                } else {
                    navigationItem.rightBarButtonItem = nil
                }
            }
            .store(in: &cancellables)
        
        viewModel.snapshotPublisher
            .sink { [unowned self] snapshot in
                diffableDatasource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        diffableDatasource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { _, _, result -> UITableViewCell? in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = result.title
            cell.detailTextLabel?.text = result.subtitle
            return cell
        })
    }
    
    private func configureSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Enter your city name"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    // MARK: - Actions
    
    @objc private func dismissSearch() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.searchController?.isActive = false
        viewModel.geolocate(selectedIndex: indexPath.row)
            .map { $0 as Location? }
            .catch { error -> Just<Location?> in
                Logger.network.error("Unable to geocode \(error)")
                return Just(nil)
            }
            .compactMap { $0 }
            .assign(to: &$chosenCity)
    }
}

extension AddCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchTerm = searchController.searchBar.text
    }
}
