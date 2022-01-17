//
//  ScoreCollectionViewCell.swift
//  MatPro
//
//  Created by Austin Betzer on 1/17/22.
//

import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ScoreCollectionViewCell"
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var containerView: UIView!
    
    private var score: Score?
    
    func setupUI(score: Score) {
        self.score = score
        scoreLabel.text = score.name
        containerView.layer.cornerRadius = containerView.frame.width / 2
    }
}
