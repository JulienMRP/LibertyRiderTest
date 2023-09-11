//
//  BreedListViewControllerTests.swift
//  LibertyRidersTestTests
//
//  Created by Perso on 9/11/23.
//

import XCTest
@testable import LibertyRiders_Test

class BreedListViewControllerTests: XCTestCase {
    var sut: BreedListViewController!
    var viewModel: MockBreedListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MockBreedListViewModel(coordinator: BreedCoordinator(nav: UINavigationController()), service: BreedService())
        sut = BreedListViewController(viewModel: viewModel)
    }

    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }

    func testReloadData() {
        sut.reloadData()
        XCTAssertTrue(viewModel.getDataCalled)
    }

    func testViewWillAppearSetsTitle() {
        sut.viewWillAppear(false)
        XCTAssertEqual(sut.title, "Cat Breeds")
    }

    func testViewWillAppearSetsLeftBarButtonItem() {
        sut.viewWillAppear(false)
        XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
    }
}
