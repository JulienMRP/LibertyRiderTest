//
//  BreedImageData+CoreDataProperties.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/11/23.
//
//

import Foundation
import CoreData


extension BreedImageData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreedImageData> {
        return NSFetchRequest<BreedImageData>(entityName: "BreedImageData")
    }

    @NSManaged public var url: String?
    @NSManaged public var imageData: Data?

}

extension BreedImageData : Identifiable {

}
