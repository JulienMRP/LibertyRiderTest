//
//  BreedDetailViewModel.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import Foundation

class BreedDetailViewModel: NSObject {
    private var coordinator: BreedCoordinator
    private var service: BreedService!
    private var breed: Breed!
    private var data: [CatImage] = [CatImage]() {
        didSet {
            self.bindDataToController()
        }
    }
    
    var bindDataToController : (() -> ()) = {}
    var onErrorHandling : ((ErrorResult) -> ()) = { _ in }

    private var index = 0
    var numberOfCells: Int {
        return data.count
    }
    
    init(coordinator: BreedCoordinator!, service: BreedService, breed: Breed!) {
        self.coordinator = coordinator
        self.breed = breed
        self.service = service
        super.init()
        getData()
    }
    
    func getData() {
        service.getImageListForBreedId(id: breed.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.onErrorHandling(error)
            case .success(let images):
                self.data = images
            }
        }
    }
    
    func getCellViewModel(indexPath: IndexPath) -> CatImage {
        return data[indexPath.row]
    }
    
    func getViewTitle() -> String {
        return breed.name
    }
}
