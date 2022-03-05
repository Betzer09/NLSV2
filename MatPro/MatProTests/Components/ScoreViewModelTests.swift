//
//  ScoreViewModelTests.swift
//  MatProTests
//
//  Created by Austin Betzer on 3/5/22.
//

import XCTest
@testable import MatPro

protocol ScoreViewModelLogic {
    var scores: LinkedList<ScoreData> {get set}
    
    func addScore(_ score: ScoreData)
    func removeScore(_ score: ScoreData)
    func undoPreviousScore(_ score: ScoreData)
}

class ScoreViewModel: ScoreViewModelLogic {
    var scores: LinkedList<ScoreData>
    
    init(scores: [ScoreData] = []) {
        self.scores = LinkedList(array: scores)
    }
    
    func addScore(_ score: ScoreData) {
        
    }
    
    func removeScore(_ score: ScoreData) {
        
    }
    
    func undoPreviousScore(_ score: ScoreData) {
        
    }
}


class ScoreViewModelTests: XCTestCase {

    var sut: ScoreViewModel!
    
    override func setUp() {
        sut = ScoreViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_addScoreToList() {
//        let score1 = makeScore()
//        let score2 = makeScore(points: 2)
//        sut.addScore(score1)
//        sut.addScore(score2)
//        XCTAssertTrue(sut.scores.)
    }
    
    func test_removeScoreFromList() {
        
    }
    
    func undoPreviousScore() {
        
    }
    
    // MARK: - Helpers
    private func makeScore(name: String = "Any Name", points: Int = 1, longName: String = "long name 1", scorer: Scorer? = nil, position: Position? = nil, isVisible: Bool = true) -> Point {
        return Point(name: name, points: points, longName: longName, scorer: scorer, position: position, isVisible: isVisible)
    }
}

