//
//  CoinsViewModelTest.swift
//  FectchingCoinsTests
//
//  Created by Khan on 22.02.2024.
//

import XCTest
@testable import FectchingCoins
class CoinsViewModelTest: XCTestCase {
    
    func testInit(){
        
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        XCTAssertNotNil(viewModel, "The view model should not nil")
    }
    
    func testSuccessFulCoinsFetch()  async {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        
        XCTAssertTrue(viewModel.coins.count > 0)
        XCTAssertEqual(viewModel.coins.count, 1)
    }
    
   
}
