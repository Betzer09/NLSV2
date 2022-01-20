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
        view.addSubview(homePointsView)
        homePointsView.translatesAutoresizingMaskIntoConstraints = false
        homePointsView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        homePointsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        homePointsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        homePointsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(awayPointsView)
        awayPointsView.translatesAutoresizingMaskIntoConstraints = false
        awayPointsView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        awayPointsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        awayPointsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        awayPointsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(scoreContainer)
        scoreContainer.translatesAutoresizingMaskIntoConstraints = false
        scoreContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scoreContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scoreContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
    }
    
    // MARK: - UI
    private lazy var homePointsView: PointsView = {
        let view = PointsView(availableScores: WrestlingScores.folkStyleNeutralScoretypes + WrestlingScores.folkStyleNeutralScoretypes )
        return view
    }()
    
    private lazy var awayPointsView: PointsView = {
        let view = PointsView(availableScores: WrestlingScores.folkStyleNeutralScoretypes + WrestlingScores.folkStyleNeutralScoretypes)
        return view
    }()
    
    private lazy var scoreContainer: ScoreView = {
        let view = ScoreView()
        return view
    }()
    
}
