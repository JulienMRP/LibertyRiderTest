//
//  BreedCoordinatorTests.swift
//  LibertyRiders TestTests
//
//  Created by Perso on 9/11/23.
//

import XCTest
@testable import LibertyRiders_Test

class BreedCoordinatorTests: XCTestCase {
    var navigationController: UINavigationController!
    var sut: BreedCoordinator!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        sut = BreedCoordinator(nav: navigationController)
    }
    
    override func tearDown() {
        navigationController = nil
        sut = nil
        super.tearDown()
    }
    
    func testStart() {
        sut.start()
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is BreedListViewController)
    }
    
    func testShowBreedDetail() {
        let breedMock = Breed(id: "Mock", name: "Mock", referenceImageId: nil)
        sut.showBreedDetail(breed: breedMock)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is BreedDetailViewController)
    }
}
