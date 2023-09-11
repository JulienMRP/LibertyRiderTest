//
//  BreedListViewModel.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import Foundation

class BreedListViewModel: NSObject {
    private var service: BreedService!
    private var coordinator: BreedCoordinator
    private var filteredData: [Breed] = [Breed]() {
        didSet {
            self.bindDataToController()
        }
    }
    private var data: [Breed] = [Breed]()
    
    
    var bindDataToController : (() -> ()) = {}
    var onErrorHandling : ((ErrorResult) -> ()) = { _ in }

    
    var numberOfCells: Int {
        return filteredData.count
    }
    
    init(coordinator: BreedCoordinator, service: BreedService) {
        self.service = service
        self.coordinator = coordinator
        super.init()
        getData()
    }
    
    func getData() {
        service.getBreedList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.onErrorHandling(error)
            case .success(let breeds):
                self.data = breeds
                self.filteredData = breeds
            }
        }
    }
    
    func filterData(filter: String) {
        if filter.count == 0 {
            self.filteredData = data
            return
        }
        self.filteredData = data.filter({ breed in
            return breed.name.uppercased().contains(filter.uppercased())
        })
    }
    
    func getCellViewModel(indexPath: IndexPath) -> Breed {
        return filteredData[indexPath.row]
    }
    
    func didSelectIndex(index: IndexPath) {
        let breed = getCellViewModel(indexPath: index)
        coordinator.showBreedDetail(breed: breed)
    }
}
