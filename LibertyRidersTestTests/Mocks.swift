//
//  Mocks.swift
//  LibertyRidersTestTests
//
//  Created by Perso on 9/11/23.
//

import UIKit
@testable import LibertyRiders_Test

class MockBreedCoordinator: BreedCoordinator {
    var showBreedDetailCalled = false
    var selectedBreed: Breed?

    override func showBreedDetail(breed: Breed) {
        showBreedDetailCalled = true
        selectedBreed = breed
    }
    
}

class MockBreedListViewModel: BreedListViewModel {
    var getDataCalled = false
    var didSelectIndexCalled = false
    var filterText: String?

    override func getData() {
        getDataCalled = true
    }

    override func didSelectIndex(index: IndexPath) {
        didSelectIndexCalled = true
    }

    override func filterData(filter: String) {
        filterText = filter
    }
}

class MockBreedService: BreedService {
    var resultBreed: Result<[Breed], ErrorResult>?
    var resultCatImage: Result<[CatImage], ErrorResult>?
    
    override func getBreedList(completion: @escaping (Result<[Breed], ErrorResult>) -> Void) {
        if let resultBreed = resultBreed {
            completion(resultBreed)
        }
    }
    
    override func getImageListForBreedId(id: String, completion: @escaping (Result<[CatImage], ErrorResult>) -> ()) {
        if let resultCatImage = resultCatImage {
            completion(resultCatImage)
        }
    }
}

class MocksData {
    let breeds = [Breed(id: "1",
                        name: "Breed1",
                        referenceImageId: nil),
                  Breed(id: "2",
                                      name: "Breed2",
                                      referenceImageId: nil)
    ]
    
    let catImages = [
        CatImage(id: "1",
                 url: "url1",
                 breedId: nil,
                 imageData: nil),
        CatImage(id: "2",
                 url: "url2",
                 breedId: nil,
                 imageData: nil)
    ]    
}

class MockBreedDetailViewModel: BreedDetailViewModel {
    var getDataCalled = false
    var viewTitle = ""

    override func getViewTitle() -> String {
        return viewTitle
    }

    override func getData() {
        getDataCalled = true
    }
}
