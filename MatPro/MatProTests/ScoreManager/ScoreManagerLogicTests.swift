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
    
    
    func test_neutral_home_takedown() throws {
        var lastScore = WrestlingScores.AllScoreTypes.takedown
        lastScore.setScorer(.home)
        lastScore.setPosition(.neutral)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleTopScoreTypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleBottomScoretypes)
    }
    
    func test_neutral_away_takedown() throws {
        var lastScore = WrestlingScores.AllScoreTypes.takedown
        lastScore.setScorer(.away)
        lastScore.setPosition(.neutral)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleBottomScoretypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleTopScoreTypes)
    }
    
    func test_top_home_nearFall() throws {
        var lastScore = WrestlingScores.AllScoreTypes.nearfallTwo
        lastScore.setScorer(.home)
        lastScore.setPosition(.top)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleTopScoreTypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleBottomScoretypes)
    }
    
    func test_top_away_nearFall() throws {
        var lastScore = WrestlingScores.AllScoreTypes.nearfallTwo
        lastScore.setScorer(.away)
        lastScore.setPosition(.top)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleBottomScoretypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleTopScoreTypes)
    }
    
    func test_bottom_away_escape() throws {
        var lastScore = WrestlingScores.AllScoreTypes.escape
        lastScore.setScorer(.away)
        lastScore.setPosition(.bottom)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleNeutralScoretypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleNeutralScoretypes)
    }
    
    func test_bottom_away_reversal() throws {
        var lastScore = WrestlingScores.AllScoreTypes.reversal
        lastScore.setScorer(.away)
        lastScore.setPosition(.bottom)
        let result = try XCTUnwrap(sut.getFolkStylePointsBasedOn(lastScore: lastScore), "expected folkstyle points to be returned got null")
        
        XCTAssertEqual(result.homePoints, WrestlingScores.folkStyleBottomScoretypes)
        XCTAssertEqual(result.opponentPoints, WrestlingScores.folkStyleTopScoreTypes)
    }
    
    func test_caution() {
        var lastScore = WrestlingScores.AllScoreTypes.caution
        lastScore.setScorer(.away)
        lastScore.setPosition(.bottom)
        XCTAssertNil(sut.getFolkStylePointsBasedOn(lastScore: lastScore, isCaution: true), "expected folkstyle points to be returned got null")
        
        
    }
    
    
    
}
