//
//  ScoreView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/17/22.
//

import Foundation
import UIKit
import TinyConstraints

class ScoreView: UIView {
    
    private var scores: [ScoreStructure] = []
    
    init(score: [ScoreStructure] = []) {
        self.scores = score
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(scores: [ScoreStructure]) {
        self.scores = scores
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let splitViewHeight = frame.height * 0.33
        homeTopScoreView.edgesToSuperview(excluding: .bottom)
        homeTopScoreView.height(splitViewHeight)
        
        awayBottomScoreView.topToBottom(of: homeTopScoreView)
        awayBottomScoreView.edgesToSuperview(excluding: [.top, .bottom])
        awayBottomScoreView.height(splitViewHeight)
        
    }
    
    // MARK: - Private
    func setupUI() {
        addSubview(backgroundContainerView)
        backgroundContainerView.edgesToSuperview(insets: .top(0), usingSafeArea: true)
        backgroundContainerView.edgesToSuperview(excluding: .top)
        
        // Constraints added in view did layout subviews
        backgroundContainerView.addSubview(homeTopScoreView)
        backgroundContainerView.addSubview(awayBottomScoreView)
    }
    

    // MARK: - UI
    private lazy var backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var homeTopScoreView: PointsCollectionView = {
        let collectionView = PointsCollectionView(scrollDirection: .horizontal)
        collectionView.backgroundColor = .orange
        var scores = [PointStructure]()
        scores.append(WrestlingScores.folkStyleNeutralScoretypes[0])
        scores.append(contentsOf: blanksScore)
        scores.append(WrestlingScores.folkStyleNeutralScoretypes[0])
        collectionView.reloadCollectionView(with: scores)
        return collectionView
    }()
    
    private lazy var awayBottomScoreView: PointsCollectionView = {
        let collectionView = PointsCollectionView(scrollDirection: .horizontal)
        collectionView.backgroundColor = .green
        return collectionView
    }()
    
    private var blanksScore: [PointStructure] {
        let data = Point(name: "", points: 10, longName: "", scorer: nil, position: nil, isVisible: false)
        return [data]
    }
}


