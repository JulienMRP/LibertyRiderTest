//
//  ImageCell.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

class ImageCell: UITableViewCell {
    static let reuseIdentifier = "ImageCell"
    
    lazy var container: UIView = {
        let _view = UIView()
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.backgroundColor = ThemeManager.shared.cardBackground
        _view.layer.cornerRadius = 2
        return _view
    }()
    
    lazy var image: UIImageView = {
        let _imageView = UIImageView()
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.contentMode = .scaleAspectFill
        _imageView.clipsToBounds = true
        _imageView.image = UIImage(named: "loading")
        return _imageView
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .green
        setupAutoLayout()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = ThemeManager.shared.backgroundColor
        container.backgroundColor = ThemeManager.shared.photoCardBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        contentView.addSubview(container)
        container.addSubview(image)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            container.heightAnchor.constraint(equalToConstant: 300),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            image.widthAnchor.constraint(equalTo: container.widthAnchor)
        ])
    }
    func configure(model: CatImage) {
        image.downloadFromModel(model: model)
    }
}


