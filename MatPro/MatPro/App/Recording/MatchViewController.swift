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
        view.backgroundColor = .red
        return view
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scoreView)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        scoreView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scoreView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scoreView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
