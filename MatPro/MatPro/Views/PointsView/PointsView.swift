//
//  ScoresView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit

class PointsView: UIView {
    // MARK: - Private properties
    private var openHeightConstraint: NSLayoutConstraint!
    private var closedHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Public properties
    private var availablePoints: [PointData] {
        didSet {
            updateScores()
        }
    }
    
    init(availableScores: [PointData]) {
        self.availablePoints = availableScores
        super.init(frame: .zero)
        
        setupUI()
        collapseView()
        updateScores()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateScores() {
        pointsCollectionView.reloadCollectionView(with: availablePoints)
    }
    
    private func setupUI() {
        
        // Background view
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true 
        openHeightConstraint = backgroundView.heightAnchor.constraint(equalTo: heightAnchor)
        closedHeightConstraint =  backgroundView.heightAnchor.constraint(equalToConstant: 44)
        openHeightConstraint.isActive = true
        closedHeightConstraint.isActive = false
        
        // Plus button
        addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        plusButton.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        plusButton.layer.cornerRadius = 22

        // Points collection View
        backgroundView.addSubview(pointsCollectionView)
        pointsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pointsCollectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        pointsCollectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        pointsCollectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        pointsCollectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        
        pointsCollectionView.setup()
    }
    
    private final func openView() {
        closedHeightConstraint.isActive = false
        openHeightConstraint.isActive = true
        pointsCollectionView.isHidden = false
        plusButton.setImage(UIImage(named: "icon-dismiss"), for: .normal)
    }
    
    private final func collapseView() {
        closedHeightConstraint.isActive = true
        openHeightConstraint.isActive = false
        pointsCollectionView.isHidden = true
        plusButton.setImage(UIImage(named: "icon-plus"), for: .normal)
    }
    
    @objc private func toggleOpenAndCollapse() {
        closedHeightConstraint.isActive ? openView() : collapseView()
    }
    
    // MARK: - UI
    lazy private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-plus"), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(toggleOpenAndCollapse), for: .touchUpInside)
        return button
    }()
    
    lazy private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 22
        return view
    }()
    
    lazy private var pointsCollectionView: PointsCollectionView = {
        let pointsCollectionView = PointsCollectionView(scrollDirection: .vertical)
        return pointsCollectionView
    }()
}
