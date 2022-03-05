//
//  ScoreCollectionViewCell.swift
//  MatPro
//
//  Created by Austin Betzer on 1/17/22.
//

import UIKit

class PointsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PointsCollectionViewCell"
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var containerView: UIView!
    
    private var score: PointStructure?
    
    func setupUI(score: PointStructure) {
        self.score = score
        scoreLabel.text = score.name
        containerView.layer.cornerRadius = containerView.frame.width / 2
        containerView.backgroundColor = score.isVisible ? .backgroundWhite : .clear
    }
}
