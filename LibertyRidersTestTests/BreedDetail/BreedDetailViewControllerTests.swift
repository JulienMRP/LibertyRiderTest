//
//  BreedDetailViewControllerTests.swift
//  LibertyRidersTestTests
//
//  Created by Perso on 9/11/23.
//


import XCTest
@testable import LibertyRiders_Test

class BreedDetailViewControllerTests: XCTestCase {
    var sut: BreedDetailViewController!
    var viewModel: MockBreedDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MockBreedDetailViewModel(coordinator: MockBreedCoordinator(nav: UINavigationController()), service: MockBreedService(), breed: MocksData().breeds[0])
        sut = BreedDetailViewController(viewModel: viewModel)
    }

    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }

    func testViewWillAppearSetsTitle() {
        viewModel.viewTitle = "Test Title"
        sut.viewWillAppear(false)
        XCTAssertEqual(sut.title, "Test Title")
    }

    func testReloadDataCallsViewModelGetData() {
        sut.reloadData()
        XCTAssertTrue(viewModel.getDataCalled)
    }
}
