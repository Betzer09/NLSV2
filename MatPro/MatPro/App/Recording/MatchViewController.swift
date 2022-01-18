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
    
    
    
    // MARK: - View Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        // Home score view
        view.addSubview(homeScoreView)
        homeScoreView.translatesAutoresizingMaskIntoConstraints = false
        homeScoreView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        homeScoreView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        homeScoreView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        homeScoreView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(awayScoreView)
        awayScoreView.translatesAutoresizingMaskIntoConstraints = false
        awayScoreView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        awayScoreView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        awayScoreView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        awayScoreView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - UI
    private lazy var homeScoreView: PointsView = {
        let view = PointsView(availableScores: WrestlingScores.folkStyleNeutralScoretypes + WrestlingScores.folkStyleNeutralScoretypes )
        return view
    }()
    
    private lazy var awayScoreView: PointsView = {
        let view = PointsView(availableScores: WrestlingScores.folkStyleNeutralScoretypes + WrestlingScores.folkStyleNeutralScoretypes)
        return view
    }()
    
}
