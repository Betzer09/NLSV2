//
//  Score.swift
//  MatPro
//
//  Created by Austin Betzer on 3/5/22.
//

import Foundation

struct Score: ScoreStructure, Equatable {
    var name: String
    var points: Int
    var scorer: Scorer?
    var longName: String
    var position: Position?
    var isVisible: Bool
    var scoredAt: TimeInterval
    
    init(name: String,
         points: Int,
         longName: String,
         scorer: Scorer? = nil,
         position: Position? = nil,
         isVisible: Bool = true,
         scoredAt: TimeInterval? = nil) {
        
        self.name = name
        self.points = points
        self.longName = longName
        self.scorer = scorer
        self.position = position
        self.isVisible = isVisible
        self.scoredAt =  scoredAt ?? Date().timeIntervalSince1970
    }
}
