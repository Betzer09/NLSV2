//
//  ScoreViewModelTests.swift
//  MatProTests
//
//  Created by Austin Betzer on 3/5/22.
//

import XCTest
@testable import MatPro

protocol ScoreViewModelOutput {
    var scores: [Score] {get set}
    var awayScores: [Score] {get}
    var homeScores: [Score] {get}
}

protocol ScoreViewModelLogic: ScoreViewModelOutput {
    func addScore(_ score: Score)
    func removeScore(_ score: Score) throws
    func undoPreviousScore(_ score: Score)
}

struct UnableToLocateScoreInListError: Error {}

/// A scores that is used to signify a space an a matches timeline out.
struct SpaceScore: ScoreStructure {
    var name: String
    var points: Int
    var scorer: Scorer?
    var longName: String
    var position: Position?
    var isVisible: Bool
    var scoredAt: TimeInterval
    
    init(awardedTo scorer: Scorer) {
        self.isVisible = true
        self.name = ""
        
        self.scoredAt = Date().timeIntervalSince1970
        self.points = 0
        self.scorer = scorer
        self.longName = ""
        self.position = nil
    }
    
}

class ScoreViewModel: ScoreViewModelLogic {
    let paddingBetweenScores: TimeInterval = 15
    
    var scores: [Score]
    
    var awayScores: [Score] {
        get {
            return scores.filter( {$0.scorer == .away} )
        }
    }
    var homeScores: [Score] {
        get {
            return scores.filter( {$0.scorer == .home} )
        }
    }
    
    init(scores: [Score] = []) {
        self.scores = scores
    }
    
    func addScore(_ score: Score) {
        scores.append(score)
    }
    
    func addScores(_ scores: [Score]) {
        self.scores.append(contentsOf: scores)
    }
    
    func removeScore(_ score: Score) throws {
        guard let scoreIndex = self.scores.firstIndex(where: {
            $0.scoredAt == score.scoredAt &&
            $0.scorer == score.scorer &&
            $0.position == score.position
        }) else {
            throw UnableToLocateScoreInListError()
        }
        
        self.scores.remove(at: scoreIndex)
        
    }
    
    func undoPreviousScore(_ score: Score) {
        scores.removeLast()
    }
    
    func generateScoreTimeline() {
        var _: [ScoreStructure]
        for (_, _) in scores.enumerated() {
            // Make sure we aren't at the first index
            // Make sure we aren't at the last index
            
            // Look at the previous element and compare time between scores
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
    
    func test_setup_withNoScores() {
        XCTAssert(sut.scores.isEmpty, "expected scores to be empty, got \(sut.scores) instead")
    }
    
    func test_setup_withScoresAdded() {
        let homeScores = generateUniqueScores(forScorer: .home)
        let awayScores = generateUniqueScores(forScorer: .away)
        sut.addScores(awayScores + homeScores)
        
        XCTAssertTrue(sut.scores.count == (homeScores + awayScores).count)
        XCTAssertTrue(sut.awayScores.count == awayScores.count)
        XCTAssertTrue(sut.homeScores.count == homeScores.count)
    }
    

    func test_add_deliversNoErrorWhenAddingNewScore() {
        let score1 = makeScore()
        sut.addScore(score1)
        XCTAssertEqual(sut.scores.last, score1)
    }
    
    func test_add_addingScoreAlsoAddsSpaceScoreToOpponent() {
//        let score1 = makeScore(scorer: .away)
//        let score2 = makeScore(scorer: .home)
//        sut.addScores([score1, score2])
//
//
//        XCTAssertTrue(sut.scores.count == 4, "expected every score to contain a separator score.")
//        let homeSeparatorCount = sut.homeScores.filter({ $0.isVisible == false }).count
//        let awaySeparatorCount = sut.awayScores.filter({ $0.isVisible == false }).count
//        XCTAssertEqual(homeSeparatorCount, 1, "expected HOME to have at least 1 separator score, got \(homeSeparatorCount) instead")
//        XCTAssertEqual(awaySeparatorCount, 1, "expected AWAY to have at least 1 separator score, got \(awaySeparatorCount) instead")
    }
    
    func test_remove_removeScoreFromCollection() {
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
    
    func test_undo_undoPreviousScoreFromCollection() {
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
                           isVisible: Bool = true) -> Score {
        
        return Score(name: name, points: points, longName: longName, scorer: scorer,
                     position: position, isVisible: isVisible, scoredAt: scoredAt)
    }
    
    
    private func generateUniqueScores(appendItemToEnd item: ScoreStructure? = nil, forScorer scorer: Scorer? = nil) -> [Score] {
        let score1 = makeScore(scorer: scorer)
        let score2 = makeScore(points: 2, scorer: scorer)
        let score3 = makeScore(points: 4, scorer: scorer)
        var scores = [score1, score2, score3]
        
        guard let item = item else {
            return scores
        }
        
        scores.append(item)
        
        return scores
    }
}

