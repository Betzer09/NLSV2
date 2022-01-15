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

func ==(lhs: Score, rhs: Score) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    return lhs.points == rhs.points && lhs.name == rhs.name && lhs.scorer == rhs.scorer && lhs.position == rhs.position
}

func !=(lhs: Score, rhs: Score) -> Bool {
    return !(lhs == rhs)
}




enum Position {
    case top, bottom, neutral
}

enum Scorer {
    case home, away
}

struct LocalScore: Score, Equatable {
    
    /// T2, E1, N3
    var name: String
    var points: Int
    /// Takedown 2, Escape 1, Nearfall 3
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



