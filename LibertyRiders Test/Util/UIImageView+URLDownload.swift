//
//  UIImageView+URLDownload.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

extension UIImageView {
    func downloadFromModel(model: CatImage) {
        self.image = UIImage(named: "loading")
        if NetworkManager().isConnected() {
            downloadFromNetwork(model: model)
        } else {
            retrieveFromCache(model: model)
        }
    }
    
    private func retrieveFromCache(model: CatImage) {
        let previousContentMode = self.contentMode
        self.contentMode = .scaleAspectFit
        StorageManager().retrieveImageData(url: model.url) { result in
            switch result {
            case .success(let imageCache):
                if let imageCache = imageCache,
                   let data = imageCache.imageData,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async() { [weak self] in
                        self?.image = image
                        self?.contentMode = previousContentMode
                    }
                } else {
                    DispatchQueue.main.async() { [weak self] in
                        self?.setNotFoundImage()
                    }
                }
            default:
                DispatchQueue.main.async() { [weak self] in
                    self?.setNotFoundImage()
                }
            }
        }
    }
    
    private func downloadFromNetwork(model: CatImage) {
        let previousContentMode = self.contentMode
        self.contentMode = .scaleAspectFit
        guard let url = URL(string: model.url) else {
            DispatchQueue.main.async() { [weak self] in
                self?.setNotFoundImage()
            }
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async() { [weak self] in
                    self?.setNotFoundImage()
                }
                return
                
            }
            
            StorageManager().saveOrUpdateImageData(model: model, data: data)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.contentMode = previousContentMode
            }
        }.resume()
    }
    
    private func setNotFoundImage() {
        self.image = UIImage(named: "not_found")
    }
}
