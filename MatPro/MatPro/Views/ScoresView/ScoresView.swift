//
//  ScoresView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit


class ScoreView: UIView {
    
    let availableScores: [Score]
    
    init(availableScores: [Score]) {
        self.availableScores = availableScores
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
