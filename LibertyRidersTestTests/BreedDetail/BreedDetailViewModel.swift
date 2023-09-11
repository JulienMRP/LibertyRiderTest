//
//  BreedDetailViewModel.swift
//  LibertyRidersTestTests
//
//  Created by Perso on 9/11/23.
//

import XCTest
@testable import LibertyRiders_Test

class BreedDetailViewModelTests: XCTestCase {
    var sut: BreedDetailViewModel!
    var mockCoordinator: MockBreedCoordinator!
    var mockService: MockBreedService!
    var mockBreed: Breed!

    override func setUp() {
        super.setUp()
        mockCoordinator = MockBreedCoordinator(nav: UINavigationController())
        mockService = MockBreedService()
        mockBreed = MocksData().breeds[0]
        sut = BreedDetailViewModel(coordinator: mockCoordinator, service: mockService, breed: mockBreed)
    }

    override func tearDown() {
        sut = nil
        mockCoordinator = nil
        mockService = nil
        mockBreed = nil
        super.tearDown()
    }

    func testGetDataSuccess() {
        mockService.resultCatImage = .success(MocksData().catImages)
        sut.getData()

        XCTAssertEqual(sut.numberOfCells, 2)
        XCTAssertEqual(sut.getCellViewModel(indexPath: IndexPath(row: 0, section: 0)).id, "1")
        XCTAssertEqual(sut.getCellViewModel(indexPath: IndexPath(row: 1, section: 0)).id, "2")
    }

    func testGetDataFailure() {
        mockService.resultCatImage = .failure(.network)
        sut.getData()
        XCTAssertEqual(sut.numberOfCells, 0)
    }

    func testGetViewTitle() {
        XCTAssertEqual(sut.getViewTitle(), "Breed1")
    }
}
