//
//  GenericViewController.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

class GenericViewController: UIViewController {
    private lazy var loadingView: LoadingView = {
        let _loadingView = LoadingView()
        _loadingView.translatesAutoresizingMaskIntoConstraints = false
        return _loadingView
    }()
    
    private lazy var emptyView: UIView = {
        let _view = UIView()
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.backgroundColor = .clear
        return _view
    }()
    
    private lazy var emptyLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.numberOfLines = 0
        _label.text = "Vous devez vous connecter au réseau pour accéder aux données de l'application"
        _label.textAlignment = .center
        return _label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        setupNetworkIcon()
        setupEmptyView()
    }
    
    private var networkManager = NetworkManager()
    
    private func setupNetworkIcon() {
        if networkManager.isConnected() {
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "(Offline)", image: nil, target: nil, action: nil)
        }
    }
    
    private func setupEmptyView() {
        emptyView.isHidden = true
        view.addSubview(emptyView)
        view.addSubview(loadingView)
        emptyView.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -30),
            emptyLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 30),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func shouldDisplayLoadingView(loading: Bool) {
        view.bringSubviewToFront(loadingView)
        loadingView.setState(state: loading ? .loading : .ended)
    }
    
    func shouldDisplayEmptyView(display: Bool) {
        emptyView.isHidden = !display
    }
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = ThemeManager.shared.blackColor
        view.backgroundColor = ThemeManager.shared.backgroundColor
    }
    
    func handleError(error: ErrorResult) {
        let message = error.errorTitle
        let alert = UIAlertController(title: "Erreur de récupération des données", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
