//
//  Breed.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import Foundation
import CoreData

struct Breed: Decodable {
    let id: String
    let name: String
    let referenceImageId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case referenceImageId = "reference_image_id"
    }
    
    func getImageUrl() -> String? {
        if let imageId = referenceImageId { 
            return "https://cdn2.thecatapi.com/images/\(imageId).jpg"
        } else {
            return nil
        }
    }
}
