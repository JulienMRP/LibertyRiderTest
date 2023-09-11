//
//  BreedList.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

final class BreedDetailViewController: GenericViewController {
    
    private var viewModel: BreedDetailViewModel
    private lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.backgroundColor = .clear
        _tableView.separatorStyle = .none
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseIdentifier)
        return _tableView
    }()

    
    init(viewModel: BreedDetailViewModel) {
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
        title = viewModel.getViewTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        self.shouldDisplayLoadingView(loading: true)

    }

    @objc
    func reloadData() {
        self.shouldDisplayLoadingView(loading: true)
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
        
    }
    
    private func setupAutoLayout() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension BreedDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = viewModel.getCellViewModel(indexPath: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell {
            cell.configure(model: image)
            return cell
        }
        fatalError("failed to dequeue OfferCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

}
