//
//  ScoreController.swift
//  MatPro
//
//  Created by Austin Betzer on 9/28/21.
//

import Foundation

protocol ScoreManagerLogic {
    func getFolkStylePointsBasedOn(lastScore: Score, isCaution: Bool) -> Points
    func returnFreestylePoints(lastScore: Score) -> Points
    func returnGrecoPoints(lastScore: Score) -> Points
}

typealias Points = (homePoints: [LocalScore], opponentPoints: [LocalScore])?


/*
 Each match you get up to five penalties total, some penalties start with a warning and then the opponent gets awarded for each one after. The match is technically over after 5 penalties, but we will leave it up to the coach to stop the match.
 */
class ScoreManager: NSObject, ScoreManagerLogic {
    
    /// Calculates and configures the current available points for folk-style.
    /// - Returns: A tuple with home-points being at the first index, the opponent points at the second.
    func getFolkStylePointsBasedOn(lastScore: Score, isCaution: Bool = false) -> Points  {
        
        var availablePoints: Points = (WrestlingScores.folkStyleNeutralScoretypes,
                                       WrestlingScores.folkStyleNeutralScoretypes)
        
        guard !isCaution else {
            return nil
        }
        
        switch lastScore.position {
        case .neutral:
            if lastScore.scorer == .home {
                // Home scored and took top position
                availablePoints = (WrestlingScores.folkStyleTopScoreTypes,
                                   WrestlingScores.folkStyleBottomScoretypes)
            } else {
                // Opponent scored and took top position
                availablePoints = (WrestlingScores.folkStyleBottomScoretypes,
                                   WrestlingScores.folkStyleTopScoreTypes)
            }
            
        case .top:
            if lastScore.scorer == .home {
                // Home scored on top points don't change.
                availablePoints = (WrestlingScores.folkStyleTopScoreTypes,
                                   WrestlingScores.folkStyleBottomScoretypes)
            } else {
                // Opponent scored on top
                availablePoints = (WrestlingScores.folkStyleBottomScoretypes,
                                   WrestlingScores.folkStyleTopScoreTypes)
            }
        case .bottom:
            if lastScore.scorer == .home  {
                // Home athlete scored
                if lastScore.longName == WrestlingScores.AllScoreTypes.escape.longName {
                    // Atheltes are now neutral
                    availablePoints = (WrestlingScores.folkStyleNeutralScoretypes,
                                       WrestlingScores.folkStyleNeutralScoretypes)
                } else if lastScore.longName == WrestlingScores.AllScoreTypes.reversal.longName {
                    availablePoints = (WrestlingScores.folkStyleTopScoreTypes,
                                       WrestlingScores.folkStyleBottomScoretypes)
                }
            } else {
                // Opponent scored
                if lastScore.longName == WrestlingScores.AllScoreTypes.escape.longName {
                    // Athletes are now neutral
                    availablePoints = (WrestlingScores.folkStyleNeutralScoretypes,
                                       WrestlingScores.folkStyleNeutralScoretypes)
                } else if lastScore.longName == WrestlingScores.AllScoreTypes.reversal.longName {
                    availablePoints = (WrestlingScores.folkStyleBottomScoretypes,
                                       WrestlingScores.folkStyleTopScoreTypes)
                } else {
                    assertionFailure("Didn't account for this case")
                }
            }
        default:
            print("A warning of some kind was given, points don't change.")
            assertionFailure("Wasn't expecting this, \(lastScore)")
            return nil
        }
        
        
        return availablePoints
    }
    
    /// Calulates and configures the current avilable points for fokstlye.
    /// - Returns: A tuple with homepoints being at the first index, the opponent points are the second index.
    func returnFreestylePoints(lastScore: Score) -> Points {
        return (WrestlingScores.freestyleGrecoPoints, WrestlingScores.freestyleGrecoPoints)
    }

    func returnGrecoPoints(lastScore: Score) -> Points {
        return(WrestlingScores.folkStyleTopScoreTypes, WrestlingScores.folkStyleBottomScoretypes)
    }
}
