//
//  MatchViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation

final class MatchViewController: RecordingViewController {
    // Right Score Collection View
    // Left Score Collection View
    // Left Score Button
    // Right Score Button
    
    private lazy var scoreView: ScoreView = {
        let view = ScoreView(availableScores: WrestlingScores.folkStyleNeutralScoretypes)
        view.backgroundColor = .white.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scoreView)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        scoreView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        scoreView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        scoreView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        scoreView.layer.cornerRadius = 22
    }
    
}
