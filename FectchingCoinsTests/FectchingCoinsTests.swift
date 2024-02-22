//
//  FectchingCoinsTests.swift
//  FectchingCoinsTests
//
//  Created by Khan on 13.02.2024.
//

import XCTest
@testable import FectchingCoins


final class FectchingCoinsTests: XCTestCase {
    func testDecodeCoinIntoArray() throws {
        
        let coins = try JSONDecoder().decode([Coin].self, from: testCoinData)
        XCTAssertTrue(coins.count > 0) // ensure that coins array has coins
        XCTAssertEqual(coins.count, 100) // ensure that all coins were decoded
    }

}
