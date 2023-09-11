//
//  Image.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import Foundation

struct CatImage: Decodable {
    let id: String
    let url: String
    var breedId: String?
    let imageData: Data?
    
    init(cacheImage: BreedImages) {
        self.id = cacheImage.imageId ?? ""
        self.breedId = cacheImage.breedId
        self.url = cacheImage.url ?? ""
        self.imageData = nil
    }
    
    init(id: String, url: String, breedId: String?, imageData: Data?) {
        self.id = id
        self.url = url
        self.breedId = breedId
        self.imageData = imageData
    }
}

