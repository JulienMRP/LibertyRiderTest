//
//  LoadingView.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/11/23.
//

import Foundation
import UIKit

enum LoadingState {
    case loading
    case ended
}

class LoadingView: UIView {

    lazy var indicator: UIActivityIndicatorView = {
        let _indicator = UIActivityIndicatorView(style: .large)
        _indicator.translatesAutoresizingMaskIntoConstraints = false
        return _indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeManager.shared.loadingBackground
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setState(state: LoadingState) {
        switch state {
        case .loading:
            indicator.startAnimating()
            self.isHidden = false
        case .ended:
            indicator.stopAnimating()
            self.isHidden = true
        }
    }
    
    private func stopLoading() {
        indicator.stopAnimating()
    }
    
}
