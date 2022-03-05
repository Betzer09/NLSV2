//
//  Score.swift
//  MatPro
//
//  Created by Austin Betzer on 3/5/22.
//

import Foundation



struct Score: ScoreStructure {
    var name: String
    var points: Int
    var scorer: Scorer?
    var longName: String
    var position: Position?
    var isVisible: Bool
    
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
    }
}
