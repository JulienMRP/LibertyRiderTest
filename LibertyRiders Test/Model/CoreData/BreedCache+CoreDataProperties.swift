//
//  BreedCache+CoreDataProperties.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/8/23.
//
//

import Foundation
import CoreData

extension BreedCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreedCache> {
        return NSFetchRequest<BreedCache>(entityName: "BreedCache")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var referenceImageId: String?

}

extension BreedCache : Identifiable {

}
