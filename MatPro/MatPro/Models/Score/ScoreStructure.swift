//
//  ScoreStructure.swift
//  MatPro
//
//  Created by Austin Betzer on 3/5/22.
//

import Foundation

protocol ScoreStructure: PointStructure {
    
}


func ==(lhs: ScoreStructure, rhs: ScoreStructure) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    return lhs.points == rhs.points && lhs.name == rhs.name && lhs.scorer == rhs.scorer && lhs.position == rhs.position
}

func !=(lhs: ScoreStructure, rhs: ScoreStructure) -> Bool {
    return !(lhs == rhs)
}
