//
//  BreedListsutTests.swift
//  LibertyRidersTestTests
//
//  Created by Perso on 9/11/23.
//


import XCTest
@testable import LibertyRiders_Test

class BreedListsutTests: XCTestCase {
    var sut: BreedListViewModel!
    var mockService: MockBreedService!
    var mockCoordinator: MockBreedCoordinator!

    override func setUp() {
        super.setUp()
        mockCoordinator = MockBreedCoordinator(nav: UINavigationController())
        mockService = MockBreedService()
        sut = BreedListViewModel(coordinator: mockCoordinator, service: mockService)
    }

    override func tearDown() {
        sut = nil
        mockCoordinator = nil
        super.tearDown()
    }

    func testGetDataSuccess() {
        mockService.resultBreed = .success(MocksData().breeds)

        sut.getData()
        XCTAssertEqual(sut.numberOfCells, 2)
        XCTAssertEqual(sut.getCellViewModel(indexPath: IndexPath(row: 0, section: 0)).name, "Breed1")
        XCTAssertEqual(sut.getCellViewModel(indexPath: IndexPath(row: 1, section: 0)).name, "Breed2")
    }

    func testGetDataFailure() {
        mockService.resultBreed = .failure(.network)
        sut.getData()
        XCTAssertEqual(sut.numberOfCells, 0)
        XCTAssertTrue(mockCoordinator.showBreedDetailCalled == false)
    }
    
    func testDidSelectIndex() {
        mockService.resultBreed = .success(MocksData().breeds)
        sut.getData()
        sut.didSelectIndex(index: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockCoordinator.showBreedDetailCalled)
    }
}
