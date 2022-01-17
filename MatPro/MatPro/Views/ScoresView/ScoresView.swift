//
//  ScoresView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit


class ScoreView: UIView {
    

    
    var availableScores: [Score] {
        didSet {
            updateScores()
        }
    }
    
    init(availableScores: [Score]) {
        self.availableScores = availableScores
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateScores() {
        
    }
    
    private func setupUI() {
        addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        plusButton.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        plusButton.layer.cornerRadius = 22
    }
    
    lazy private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-plus"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
}
