//
//  BreedListViewController.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

final class BreedListViewController: GenericViewController {
    
    private var viewModel: BreedListViewModel

    private lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.backgroundColor = .clear
        _tableView.separatorStyle = .none
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseIdentifier)
        return _tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
       let _searchBar = UISearchBar()
        _searchBar.delegate = self
        _searchBar.translatesAutoresizingMaskIntoConstraints = false
        return _searchBar
    }()
    
    init(viewModel: BreedListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAutoLayout()
        title = "Cat Breeds"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        self.shouldDisplayLoadingView(loading: true)
    }
    
    @objc
    func reloadData() {
        viewModel.getData()
    }
    
    private func setupViewModel() {
        viewModel.bindDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.shouldDisplayEmptyView(display: false)
                self.shouldDisplayLoadingView(loading: false)
            }
        }
        viewModel.onErrorHandling = { error in
            switch error {
            case .localStorageEmpty:
                self.shouldDisplayEmptyView(display: true)
                self.shouldDisplayLoadingView(loading: false)
            default:
                DispatchQueue.main.async {
                    self.handleError(error: error)
                    self.shouldDisplayLoadingView(loading: false)
                }
            }
        }
        viewModel.getData()
    }
    
    private func setupAutoLayout() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension BreedListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breed = viewModel.getCellViewModel(indexPath: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseIdentifier, for: indexPath) as? BreedCell {
            cell.configure(model: breed)
            return cell
        }
        fatalError("failed to dequeue cell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectIndex(index: indexPath)
    }
    
}

extension BreedListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterData(filter: searchText)
        
    }
}

