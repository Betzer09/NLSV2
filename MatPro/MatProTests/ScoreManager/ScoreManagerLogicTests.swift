//
//  ScoreManagerLogicTests.swift
//  MatProTests
//
//  Created by Austin Betzer on 9/28/21.
//

import XCTest
@testable import MatPro

class ScoreManagerLogicTests: XCTestCase {
    var sut: ScoreManager!
    
    override func setUp() {
        sut = ScoreManager()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    
    func test_neutral_home() throws {
        var lastScore = WrestlingScores.AllScoreTypes.takedown
        lastScore.setScorer(.home)
        lastScore.setPosition(.neutral)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleTopScoreTypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleBottomScoretypes)
    }
    
    func test_neutral_away() throws {
        var lastScore = WrestlingScores.AllScoreTypes.takedown
        lastScore.setScorer(.away)
        lastScore.setPosition(.neutral)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleBottomScoretypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleTopScoreTypes)
    }
    
}
