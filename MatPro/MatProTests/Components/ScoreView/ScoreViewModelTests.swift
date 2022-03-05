//
//  ScoreViewModelTests.swift
//  MatProTests
//
//  Created by Austin Betzer on 3/5/22.
//

import XCTest
@testable import MatPro

protocol ScoreViewModelLogic {
    var scores: LinkedList<ScoreStructure> {get set}
    
    func addScore(_ score: ScoreStructure)
    func removeScore(_ score: ScoreStructure)
    func undoPreviousScore(_ score: ScoreStructure)
}

class ScoreViewModel: ScoreViewModelLogic {
    var scores: LinkedList<ScoreStructure>
    
    init(scores: [ScoreStructure] = []) {
        self.scores = LinkedList(array: scores)
    }
    
    func addScore(_ score: ScoreStructure) {
        scores.append(score)
    }
    
    func removeScore(_ score: ScoreStructure) {
        
    }
    
    func undoPreviousScore(_ score: ScoreStructure) {
        
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
        let score1 = makeScore()
        let score2 = makeScore(points: 2)
        sut.addScore(score1)
        sut.addScore(score2)
        XCTAssertTrue(sut.scores.count == 2)
        XCTAssertEqual(sut.scores.last?.value.points, score2.points)
    }
    
    func test_removeScoreFromList() {
        
    }
    
    func undoPreviousScore() {
        
    }
    
    // MARK: - Helpers
    private func makeScore(name: String = "Any Name",
                           points: Int = 1,
                           longName: String = "long name 1",
                           scorer: Scorer? = nil,
                           position: Position? = nil,
                           isVisible: Bool = true) -> ScoreStructure {
        
        return Score(name: name, points: points, longName: longName, scorer: scorer, position: position, isVisible: isVisible)
    }
}

