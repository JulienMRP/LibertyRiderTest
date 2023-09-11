//
//  BreedService.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import Foundation
import CoreData

enum ErrorResult: Error {
    case parsing
    case network
    case localStorageEmpty
    
    var errorTitle: String {
        switch self {
        case .parsing:
            return "Impossible de lire les données"
        case .network:
            return "Une erreur réseau s'est produite"
        case .localStorageEmpty:
            return "Vous devez vous connecter au réseau pour charger les données"
        }
    }
}

class BreedService: NSObject {
    private let apiUrl = "https://api.thecatapi.com/"
    private let networkManager = NetworkManager()
    private let storageManager = StorageManager()
    
    private func makeUrl(object: String, parameters: [String]) -> URL? {
        var stringUrl = "\(apiUrl)/v1/\(object)?"
        parameters.forEach { param in
            stringUrl.append(param)
            stringUrl.append("&")
        }
        return URL(string: stringUrl )
    }
    
    func saveCacheBreeds(breeds: [Breed]) {
        breeds.forEach { breed in
            storageManager.saveOrUpdateBreed(breed: breed)
        }
    }
    
    func saveCacheImages(images: [CatImage]) {
        images.forEach { image in
            storageManager.saveOrUpdateImage(model: image)
        }
    }
    
    func retrieveCacheBreeds(completion: @escaping (Result<[Breed], ErrorResult>) -> ()) {
        storageManager.retrieveAllBreed { result in
            switch result {
            case .success(let breeds):
                if breeds.isEmpty {
                    completion(Result.failure(.localStorageEmpty))
                } else {
                    completion(Result.success(breeds))
                }
            case .failure(let failure):
                completion(Result.failure(failure))
            }
        }
    }
    
    func retrieveImagesFromCache(breedId: String, completion: @escaping (Result<[CatImage], ErrorResult>) -> ()) {
        storageManager.retrieveAllImages(breedId: breedId) { result in
            switch result {
            case .success(let breeds):
                if breeds.isEmpty {
                    completion(Result.failure(.localStorageEmpty))
                } else {
                    completion(Result.success(breeds))
                }
            case .failure(let failure):
                completion(Result.failure(failure))
            }
        }
    }
    
    func getBreedList(completion: @escaping (Result<[Breed], ErrorResult>) -> ()) {
        guard let url = makeUrl(object: "breeds", parameters: []) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")

        if networkManager.isConnected() {
            URLSession.shared.dataTask(with: request) { data, response, error -> Void in
                if let httpResponse = response as? HTTPURLResponse {
                    if let data = data, httpResponse.statusCode.isValidResponse() {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let emptData = try jsonDecoder.decode([Breed].self, from: data)
                            self.saveCacheBreeds(breeds: emptData)
                            completion(Result.success(emptData))
                        } catch {
                            completion(Result.failure(.parsing))
                        }
                    }else {
                        completion(Result.failure(.parsing))
                    }
                } else {
                    completion(Result.failure(.network))
                }
            }.resume()
        } else {
            retrieveCacheBreeds(completion: completion)
        }
    }
    
    func getImageListForBreedId(id: String, completion: @escaping (Result<[CatImage], ErrorResult>) -> ()) {
        if networkManager.isConnected() {
            let params = [
                "limit=100&",
                "include_breeds=false&",
                "breed_ids=\(id)"
            ]
            
            guard let url = makeUrl(object: "images/search", parameters: params) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue("x-api-key", forHTTPHeaderField: "live_NQmJQaewBqyxAmiSnOEMfNE0IqPgX7fzO73m0CwdLB4NASWcNRVnBzHAza0OfLdU")
            URLSession.shared.dataTask(with: request) { data, response, error -> Void in
                if let httpResponse = response as? HTTPURLResponse {
                    if let data = data, httpResponse.statusCode.isValidResponse() {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let emptData = try jsonDecoder.decode([CatImage].self, from: data)
                            let formatedData = emptData.map { image in
                                return CatImage(id: image.id,
                                                 url: image.url,
                                                 breedId: id,
                                                 imageData: image.imageData)
                            }
                            self.saveCacheImages(images: formatedData)
                            completion(Result.success(formatedData))
                        } catch {
                            completion(Result.failure(.parsing))
                        }
                    }else {
                    }
                } else {
                    completion(Result.failure(.network))
                }
            }.resume()
        } else {
            retrieveImagesFromCache(breedId: id, completion: completion)
        }
        
    }
}

extension Int {
    func isValidResponse() -> Bool {
        return self > 199 && self < 300
    }
}
