//
//  Coordinator.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
