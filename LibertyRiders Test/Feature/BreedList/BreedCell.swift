//
//  BreedCell.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

class BreedCell: UITableViewCell {
    static let reuseIdentifier = "BreedCell"
    
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
    
    lazy var nameLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 2
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        _label.textAlignment = .center
        return _label
    }()
    
    lazy var informationStackView: UIStackView = {
        let _stackView = UIStackView(arrangedSubviews: [nameLabel])
        _stackView.axis = .vertical
        _stackView.spacing = 10
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        return _stackView
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(informationStackView)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            image.widthAnchor.constraint(equalTo: container.widthAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            informationStackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            informationStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            informationStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            informationStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5)

        ])
    }
    func configure(model: Breed) {
        nameLabel.text = model.name
        if let url = model.getImageUrl() {
            let catImage = CatImage(id: model.referenceImageId ?? "",
                                    url: url,
                                    breedId: model.id,
                                    imageData: nil)
            image.downloadFromModel(model: catImage)
        }
       
    }
}
