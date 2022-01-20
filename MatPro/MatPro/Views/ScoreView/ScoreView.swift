//
//  ScoreView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/17/22.
//

import Foundation
import UIKit

class ScoreView: UIView {
    
    private var scores: [ScoreData] = []
    
    init(score: [ScoreData] = []) {
        self.scores = score
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(scores: [ScoreData]) {
        self.scores = scores
    }
    
    // MARK: - Private
    func setupUI() {
        addSubview(backgroundContainerView)
        backgroundContainerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    

    // MARK: - UI
    private lazy var backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var homeScoreView: PointsCollectionView = {
        let collectionView = PointsCollectionView(scrollDirection: .horizontal)
        return collectionView
    }()
    
    private lazy var awayScoreView: PointsCollectionView = {
        let collectionView = PointsCollectionView(scrollDirection: .horizontal)
        return collectionView
    }()
}
