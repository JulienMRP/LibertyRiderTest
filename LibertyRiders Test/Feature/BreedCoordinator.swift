//
//  BreedCoordinator.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

protocol BreedCoordinatorLogic: Coordinator {
    func showBreedDetail(breed: Breed)
}

class BreedCoordinator: BreedCoordinatorLogic {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var breedService = BreedService()
    
    init(nav: UINavigationController) {
        navigationController = nav
    }
    
    func start() {
        let apiService = BreedService()
        let viewModel = BreedListViewModel(coordinator: self, service: apiService)
        let viewController = BreedListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showBreedDetail(breed: Breed) {
        let vm = BreedDetailViewModel(coordinator: self,
                                      service: breedService,
                                      breed: breed)
        let vc = BreedDetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
