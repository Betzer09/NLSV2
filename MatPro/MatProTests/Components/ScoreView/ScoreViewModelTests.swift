//
//  ScoreViewModelTests.swift
//  MatProTests
//
//  Created by Austin Betzer on 3/5/22.
//

import XCTest
@testable import MatPro

protocol ScoreViewModelOutput {
    var scores: LinkedList<ScoreStructure> {get set}
    var awayScores: LinkedList<ScoreStructure> {get}
    var homeScores: LinkedList<ScoreStructure> {get}
}

protocol ScoreViewModelLogic: ScoreViewModelOutput {
    func addScore(_ score: ScoreStructure)
    func removeScore(_ score: ScoreStructure) throws
    func undoPreviousScore(_ score: ScoreStructure)
}

struct UnableToLocateScoreInListError: Error {}

class ScoreViewModel: ScoreViewModelLogic {
    let paddingBetweenScores: TimeInterval = 15
    
    var scores: LinkedList<ScoreStructure>
    var awayScores: LinkedList<ScoreStructure> {
        get {
            scores.filter(predicate: { $0.scorer == .away })
        }
    }
    var homeScores: LinkedList<ScoreStructure> {
        get {
            scores.filter(predicate: { $0.scorer == .home })
        }
    }
    
    init(scores: [ScoreStructure] = []) {
        self.scores = LinkedList(array: scores)
    }
    
    func addScore(_ score: ScoreStructure) {
        scores.append(score)
    }
    
    func addScore(_ scores: [ScoreStructure]) {
        scores.forEach { score in
            self.scores.append(score)
        }
    }
    
    func removeScore(_ score: ScoreStructure) throws {
        
        guard let scoreIndex = scores.firstIndex(where: {$0.points == score.points && $0.scoredAt == score.scoredAt})else {
            throw UnableToLocateScoreInListError()
        }
        
        let scoreNode = scores.node(at: scoreIndex as! Int)
        let node = scores.remove(node: scoreNode)
    }
    
    func undoPreviousScore(_ score: ScoreStructure) {
        scores.removeLast()
    }
    
    func generateScoreTimeline() {
        var head = scores.head
        var iteration = 0
        while head != nil {
            if iteration > 0 {
                head = head?.next
                
            }
            
            iteration += 1
        }
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
    
    func test_setup() {
        let score1 = makeScore(scorer: .home)
        let score3 = makeScore(points: 4,  scorer: .home)
        let homeScores = [score1, score3]
        
        let score2 = makeScore(points: 2, scorer: .away)
        let score4 = makeScore(scorer: .away)
        let score5 = makeScore(scorer: .away)
        let awayScores = [score2, score4, score5]
        sut.addScore(awayScores)
        sut.addScore(homeScores)
        
        XCTAssertTrue(sut.scores.count == (homeScores + awayScores).count)
        XCTAssertTrue(sut.awayScores.count == awayScores.count)
        XCTAssertTrue(sut.homeScores.count == homeScores.count)
    }
    
    func test_timelineGenerateScoreOffSetsBetweenScoresBasedOnTimeScored() {
        let score1 = makeScore(scorer: .home, scoredAt: 1)
        let score3 = makeScore(points: 4,  scorer: .home, scoredAt: 20) // + 1 Padding
        let homeScores = [score1, score3] // three total points
        
        let score2 = makeScore(points: 2, scorer: .away, scoredAt: 5)
        let score4 = makeScore(scorer: .away, scoredAt: 10)
        let score5 = makeScore(scorer: .away, scoredAt: 45) // + 1 padding
        let awayScores = [score2, score4, score5]
        
        let totalPoints = (homeScores + awayScores).shuffled()
        sut.addScore(totalPoints)
        
        let homeAdditionalPointsAddedForPadding = sut.homeScores.filter(predicate: {$0.name == "" && !$0.isVisible})
        assert(homeAdditionalPointsAddedForPadding.count > 0, "expected at least one padding score added to list")
        let awayAdditionalPointsAddedForPadding =  sut.awayScores.filter(predicate: {$0.name == "" && !$0.isVisible})
        assert(awayAdditionalPointsAddedForPadding.count > 0, "expected at least one padding score added to list")
        XCTAssertTrue(sut.awayScores.count == (homeAdditionalPointsAddedForPadding + awayScores).count)
        XCTAssertTrue(sut.homeScores.count == (awayAdditionalPointsAddedForPadding + homeScores).count)
        XCTAssertTrue(sut.homeScores.count == homeScores.count)
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
//        let score1 = makeScore()
//        let score2 = makeScore(points: 2)
//        let score3 = makeScore(points: 4)
//        sut.addScore(score1)
//        sut.addScore(score2)
//        sut.addScore(score3)
//        try? sut.removeScore(score3)
//        XCTAssertTrue(sut.scores.count == 2)
//        XCTAssertEqual(sut.scores.last?.value.points, score2.points)
    }
    
    func test_undoPreviousScore() {
        let score1 = makeScore()
        let score2 = makeScore(points: 2)
        let score3 = makeScore(points: 4)
        sut.addScore(score1)
        sut.addScore(score2)
        sut.addScore(score3)
        sut.scores.removeLast()
        
        XCTAssertTrue(sut.scores.count == 2)
        XCTAssertEqual(sut.scores.last?.value.points, score2.points)
    }
    
    // MARK: - Helpers
    private func makeScore(name: String = "Any Name",
                           points: Int = 1,
                           longName: String = "long name 1",
                           scorer: Scorer? = nil,
                           position: Position? = nil,
                           scoredAt: TimeInterval? = nil,
                           isVisible: Bool = true) -> ScoreStructure {
        
        return Score(name: name, points: points, longName: longName, scorer: scorer,
                     position: position, isVisible: isVisible, scoredAt: scoredAt)
    }
    
    private func setupLinkedList() -> LinkedList<ScoreStructure>{
        let linkedList = LinkedList<ScoreStructure>()
        let score1 = makeScore()
        let score2 = makeScore(points: 2)
        let score3 = makeScore(points: 4)
        sut.addScore(score1)
        sut.addScore(score2)
        sut.addScore(score3)
        
        return linkedList
    }
}

