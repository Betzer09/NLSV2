//
//  MatchViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit

final class MatchViewController: RecordingViewController {
    // Right Score Collection View
    // Left Score Collection View
    // Left Score Button
    // Right Score Button
    
    private lazy var homeScoreView: ScoreView = {
        let view = ScoreView(availableScores: WrestlingScores.folkStyleNeutralScoretypes)
        return view
    }()
    
    // MARK: - View Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        // Home Score View
        view.addSubview(homeScoreView)
        homeScoreView.translatesAutoresizingMaskIntoConstraints = false
        homeScoreView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        homeScoreView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        homeScoreView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        homeScoreView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        homeScoreView.collapseView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.homeScoreView.openView()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.homeScoreView.collapseView()
        }
    }
    
}
