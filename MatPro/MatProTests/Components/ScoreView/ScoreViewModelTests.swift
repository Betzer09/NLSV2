//
//  ScoreViewModelTests.swift
//  MatProTests
//
//  Created by Austin Betzer on 3/5/22.
//

import XCTest
@testable import MatPro

protocol ScoreViewModelOutput {
    var scores: [ScoreStructure] {get set}
    var awayScores: [ScoreStructure] {get}
    var homeScores: [ScoreStructure] {get}
}

protocol ScoreViewModelLogic: ScoreViewModelOutput {
    func addScore(_ score: ScoreStructure)
    func removeScore(_ score: ScoreStructure) throws
    func undoPreviousScore(_ score: ScoreStructure)
}

struct UnableToLocateScoreInListError: Error {}

class ScoreViewModel: ScoreViewModelLogic {
    let paddingBetweenScores: TimeInterval = 15
    
    var scores: [ScoreStructure]
    
    var awayScores: [ScoreStructure] {
        get {
            return scores.filter( {$0.scorer == .away} )
        }
    }
    var homeScores: [ScoreStructure] {
        get {
            return scores.filter( {$0.scorer == .home} )
        }
    }
    
    init(scores: [ScoreStructure] = []) {
        self.scores = scores
    }
    
    func addScore(_ score: ScoreStructure) {
        scores.append(score)
    }
    
    func addScores(_ scores: [ScoreStructure]) {
        self.scores.append(contentsOf: scores)
    }
    
    func removeScore(_ score: ScoreStructure) throws {
        guard let scoreIndex = self.scores.firstIndex(where: {
            $0.scoredAt == score.scoredAt &&
            $0.scorer == score.scorer &&
            $0.position == score.position
        }) else {
            throw UnableToLocateScoreInListError()
        }
        
        self.scores.remove(at: scoreIndex)
        
    }
    
    func undoPreviousScore(_ score: ScoreStructure) {
        scores.removeLast()
    }
    
    func generateScoreTimeline() {
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
        sut.addScores(awayScores)
        sut.addScores(homeScores)
        
        XCTAssertTrue(sut.scores.count == (homeScores + awayScores).count)
        XCTAssertTrue(sut.awayScores.count == awayScores.count)
        XCTAssertTrue(sut.homeScores.count == homeScores.count)
    }
    
    func test_timelineGenerateScoreOffSetsBetweenScoresBasedOnTimeScored() {
//        let score1 = makeScore(scorer: .home, scoredAt: 1)
//        let score3 = makeScore(points: 4,  scorer: .home, scoredAt: 20) // + 1 Padding
//        let homeScores = [score1, score3] // three total points
//
//        let score2 = makeScore(points: 2, scorer: .away, scoredAt: 5)
//        let score4 = makeScore(scorer: .away, scoredAt: 10)
//        let score5 = makeScore(scorer: .away, scoredAt: 45) // + 1 padding
//        let awayScores = [score2, score4, score5]
//
//        let totalPoints = (homeScores + awayScores).shuffled()
//        sut.addScore(totalPoints)
//
//        let homeAdditionalPointsAddedForPadding = sut.homeScores.filter({$0.name == "" && !$0.isVisible})
//        assert(homeAdditionalPointsAddedForPadding.count > 0, "expected at least one padding score added to list")
//        let awayAdditionalPointsAddedForPadding =  sut.awayScores.filter({$0.name == "" && !$0.isVisible})
//        assert(awayAdditionalPointsAddedForPadding.count > 0, "expected at least one padding score added to list")
//        XCTAssertTrue(sut.awayScores.count == (homeAdditionalPointsAddedForPadding + awayScores).count)
//        XCTAssertTrue(sut.homeScores.count == (awayAdditionalPointsAddedForPadding + homeScores).count)
//        XCTAssertTrue(sut.homeScores.count == homeScores.count)
    }

    func test_addScoreToList() {
        let score1 = makeScore()
        let score2 = makeScore(points: 2)
        sut.addScore(score1)
        sut.addScore(score2)
        XCTAssertTrue(sut.scores.count == 2)
        XCTAssertEqual(sut.scores.last?.points, score2.points)
    }
    
    func test_removeScoreFromList() {
        let score1 = makeScore()
        let score2 = makeScore(points: 2)
        let score3 = makeScore(points: 4)
        sut.addScore(score1)
        sut.addScore(score2)
        sut.addScore(score3)
        try! sut.removeScore(score3)
        XCTAssertTrue(sut.scores.count == 2)
        XCTAssertEqual(sut.scores.last?.points, score2.points)
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
        XCTAssertEqual(sut.scores.last?.points, score2.points)
    }
    
    // MARK: - Helpers
    private func makeScore(name: String = "Any Name",
                           points: Int = 1,
                           longName: String = "long name 1",
                           scorer: Scorer? = [.home, .away].randomElement(),
                           position: Position? = [.top, .bottom, .neutral].randomElement(),
                           scoredAt: TimeInterval? = Date().timeIntervalSince1970,
                           isVisible: Bool = true) -> ScoreStructure {
        
        return Score(name: name, points: points, longName: longName, scorer: scorer,
                     position: position, isVisible: isVisible, scoredAt: scoredAt)
    }
    
    
    private func generateUniqueScores(appendItemToEnd item: ScoreStructure) -> [ScoreStructure] {
        let score1 = makeScore()
        let score2 = makeScore(points: 2)
        let score3 = makeScore(points: 4)
        return [score1, score2, score3]
    }
}

