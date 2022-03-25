//
//  Score.swift
//  MatPro
//
//  Created by Austin Betzer on 9/28/21.
//

import Foundation


enum Position {
    case top, bottom, neutral
}

enum Scorer {
    case home, away
}

struct Point: PointStructure, Equatable {
    
    
    var name: String
    var points: Int
    var longName: String
    var scorer: Scorer?
    var position: Position?
    var isVisible: Bool
    var scoredAt: TimeInterval
    
    init(name: String,
         points: Int,
         longName: String,
         scorer: Scorer? = nil,
         position: Position? = nil,
         isVisible: Bool = true) {
        
        self.name = name
        self.points = points
        self.longName = longName
        self.scorer = scorer
        self.position = position
        self.isVisible = isVisible
        self.scoredAt = Date().timeIntervalSince1970
    }
}



