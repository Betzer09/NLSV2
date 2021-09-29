//
//  Score.swift
//  MatPro
//
//  Created by Austin Betzer on 9/28/21.
//

import Foundation

protocol Score {
    var name: String {get}
    var points: Int {get set}
    var scorer: Scorer? {get set}
    var longName: String {get}
    var position: Position? {get set}
}

enum Position {
    case top, bottom, neutral
}

enum Scorer {
    case home, away
}

struct LocalScore: Score {
    
    var name: String
    var points: Int
    var longName: String
    var scorer: Scorer?
    var position: Position?
    
    mutating func setPoints(_ points: Int) {
        self.points = points
    }
    
    mutating func setScorer(_ scorer: Scorer) {
        self.scorer = scorer
    }
    
    mutating func setPosition(_ position: Position) {
        self.position = position
    }
}



