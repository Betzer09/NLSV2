//
//  PointStructure.swift
//  MatPro
//
//  Created by Austin Betzer on 3/5/22.
//

import Foundation

protocol PointStructure {
    /// The  short name of the point, typically this name should match the short hand for whatever sport it's representing, ex in wrestling would be T2, E1, N3
    var name: String {get}
    var points: Int {get set}
    var scorer: Scorer? {get set}
    /// Takedown 2, Escape 1, Nearfall 3
    var longName: String {get}
    var position: Position? {get set}
    /// Dictates whether a score is visible or not
    var isVisible: Bool {get}
    var scoredAt: TimeInterval {get}
    
    mutating func setPoints(_ points: Int)
    mutating func setScorer(_ scorer: Scorer)
    mutating func setPosition(_ position: Position)
}

extension PointStructure {
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


func ==(lhs: PointStructure, rhs: PointStructure) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    return lhs.points == rhs.points && lhs.name == rhs.name && lhs.scorer == rhs.scorer && lhs.position == rhs.position
}

func !=(lhs: PointStructure, rhs: PointStructure) -> Bool {
    return !(lhs == rhs)
}
