//
//  StorageManager.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/8/23.
//

import UIKit
import CoreData

final class StorageManager {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Breeds")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    
    func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func retrieveImageData(url: String, completion: @escaping (Result<BreedImageData?, ErrorResult>) -> ()) {
        let fetchRequest = BreedImageData.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "url LIKE %@", url
        )
        fetchRequest.fetchLimit = 1
        do {
            if let object = try persistentContainer.viewContext.fetch(fetchRequest).first {
                completion(Result.success(object))
            }
            completion(Result.success(nil))
        } catch {
            completion(Result.failure(.parsing))
        }
    }
    
    func retrieveImage(id: String, completion: @escaping (Result<BreedImages?, ErrorResult>) -> ()) {
        let fetchRequest = BreedImages.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "imageId LIKE %@", id
        )
        fetchRequest.fetchLimit = 1
        do {
            if let object = try persistentContainer.viewContext.fetch(fetchRequest).first {
                completion(Result.success(object))
            }
            completion(Result.success(nil))
        } catch {
            completion(Result.failure(.parsing))
        }
    }
    
    func retrieveBreedCache(id: String, completion: @escaping (Result<BreedCache?, ErrorResult>) -> ()) {
        let fetchRequest = BreedCache.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id LIKE %@", id
        )
        fetchRequest.fetchLimit = 1
        do {
            let object = try persistentContainer.viewContext.fetch(fetchRequest).first
            completion(Result.success(object))
        } catch {
            completion(Result.failure(.parsing))
        }
    }
    
    func retrieveAllBreed(completion: @escaping (Result<[Breed], ErrorResult>) -> ()) {
        let fetchRequest = BreedCache.fetchRequest()
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            var breeds: [Breed] = []
            breeds = result.map { breedCache in
                return Breed(id: breedCache.id ?? "",
                             name: breedCache.name ?? "",
                             referenceImageId: breedCache.referenceImageId)
            }
            completion(Result.success(breeds))
        }
        catch {
            completion(Result.failure(.parsing))
        }
    }
    
    func retrieveAllImages(breedId: String, completion: @escaping (Result<[CatImage], ErrorResult>) -> ()) {
        let fetchRequest = BreedImages.fetchRequest()
        do {
            fetchRequest.predicate = NSPredicate(
                format: "breedId LIKE %@", breedId
            )
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            var images: [CatImage] = []
            images = result.map { imacheCache in
                return CatImage(cacheImage: imacheCache)
            }
            completion(Result.success(images))
        }
        catch {
            completion(Result.failure(.parsing))
        }
    }
    
    func saveOrUpdateImageData(model: CatImage, data: Data) {
        retrieveImageData(url: model.url) { result in
            switch result {
            case .success(let object):
                if let imageCache = object {
                    self.persistentContainer.viewContext.delete(imageCache)
                }
            default:
                break
                    
            }
            self.saveNewImageData(url: model.url, data: data)
        }
    }
    
    func saveOrUpdateImage(model: CatImage) {
        retrieveImage(id: model.id) { result in
            switch result {
            case .success(let object):
                if let imageCache = object {
                    self.persistentContainer.viewContext.delete(imageCache)
                }
            default:
                break
                    
            }
            self.saveNewImage(model: model)
        }
    }
    
    func saveNewImage(model: CatImage) {
        let imageCache = BreedImages(context: persistentContainer.viewContext)
        imageCache.url = model.url
        imageCache.imageId = model.id
        imageCache.breedId = model.breedId
        self.saveContext()
    }
    
    func saveNewImageData(url: String, data: Data) {
        let imageData = BreedImageData(context: persistentContainer.viewContext)
        imageData.url = url
        imageData.imageData = data
        self.saveContext()
    }
    
    func saveNewBreedCache(breed: Breed) {
        let breedCache = BreedCache(context: persistentContainer.viewContext)
        breedCache.referenceImageId = breed.referenceImageId ?? "test"
        breedCache.id = breed.id
        breedCache.name = breed.name
        print(breedCache)
        saveContext()
    }
    
    func saveOrUpdateBreed(breed: Breed) {
        retrieveBreedCache(id: breed.id) { result in
            switch result {
            case .success(let object):
                if let breedCache = object {
                    self.persistentContainer.viewContext.delete(breedCache)
                }
            default:
                break
            }
            self.saveNewBreedCache(breed: breed)
        }
    }
}
