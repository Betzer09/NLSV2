//
//  ScoreContants.swift
//  MatPro
//
//  Created by Austin Betzer on 9/28/21.
//

import Foundation

struct ScoreConstants {
    static let reversal = "Reversal"
    static let nearfallThree = "Near Fall Three"
    static let onePoint = "One"
    static let twoPoints = "Two"
    static let fourPoints = "Four"
    static let fivePoints = "Five"
    static let escape = "Escape"
    static let takedown = "Takedown"
    static let nearfallTwo = "Near Fall Two"
    static let techViolation = "Tech Violation"
    static let caution = "Caution"
    static let stalling = "Stalling"
}

// MARK: - Wrestling Scores
struct WrestlingScores {
    
    struct AllScoreTypes {
        // Folk-style points
        static let reversal = Point(name: "R2", points: 2, longName: ScoreConstants.reversal)
        static let nearfallThree = Point(name: "N3", points: 3, longName: ScoreConstants.nearfallThree)
        
        // Freestyle & Greco
        static let onePoint = Point(name: "1", points: 1, longName: ScoreConstants.onePoint)
        static let twoPoints = Point(name: "2", points: 2, longName: ScoreConstants.twoPoints)
        static let fourPoints = Point(name: "4", points: 4, longName: ScoreConstants.fourPoints)
        static let fivePoints = Point(name: "5", points: 5, longName: ScoreConstants.fivePoints)
        
        // Points that fit in all styles
        static let escape = Point(name: "E1", points: 1, longName: ScoreConstants.escape)
        static let takedown = Point(name: "T2", points: 2, longName: ScoreConstants.takedown)
        static let nearfallTwo = Point(name: "N2", points: 2, longName: ScoreConstants.nearfallTwo)
        
        // The first two are a point, the third is 2 pints and the fourth is disqualification/
        static var techViolation = Point(name: "TV", points: 0, longName: ScoreConstants.techViolation)
        
        // Anything over two caution is a point
        // After 4 cautions the match is over
        static var caution = Point(name: "C", points: 0, longName: ScoreConstants.caution)
        
        // First stalling call is a warning, the next two are 1 point and anything after that is 2
        static var stalling = Point(name: "S", points: 0, longName: ScoreConstants.stalling)
    }
    
    
    
    /// Folk Style Neutral Scoretypes
    static var folkStyleNeutralScoretypes: [Point] {
        return [WrestlingScores.AllScoreTypes.takedown] + warnings
    }
    
    static var folkStyleTopScoreTypes: [Point] {
        return [
            WrestlingScores.AllScoreTypes.nearfallTwo,
            WrestlingScores.AllScoreTypes.nearfallThree
        ] + warnings
    }
    
    static  var folkStyleBottomScoretypes: [Point] {
        return [
            WrestlingScores.AllScoreTypes.reversal,
            WrestlingScores.AllScoreTypes.escape
        ] + warnings
    }
    
    static  var warnings: [Point] {
        return [
            WrestlingScores.AllScoreTypes.stalling,
            WrestlingScores.AllScoreTypes.caution,
            WrestlingScores.AllScoreTypes.techViolation
        ]
    }
    
    // Freestyle greco
    static  var freestyleGrecoWarnings: [Point] {
        return [WrestlingScores.AllScoreTypes.caution]
    }
    
    /// Points available in freestyle and greco, theses don't change. All points are always readaly available.
    static  var freestyleGrecoPoints: [Point] {
        return [
            WrestlingScores.AllScoreTypes.onePoint,
            WrestlingScores.AllScoreTypes.twoPoints,
            WrestlingScores.AllScoreTypes.fourPoints,
            WrestlingScores.AllScoreTypes.fivePoints,
            WrestlingScores.AllScoreTypes.caution
        ]
    }
    
}

