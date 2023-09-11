//
//  BreedImages+CoreDataProperties.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/11/23.
//
//

import Foundation
import CoreData


extension BreedImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreedImages> {
        return NSFetchRequest<BreedImages>(entityName: "BreedImages")
    }

    @NSManaged public var url: String?
    @NSManaged public var breedId: String?
    @NSManaged public var imageId: String?

}

extension BreedImages : Identifiable {

}
