//
//  ScoresView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit

protocol ScoreViewDelegate: AnyObject {
    
}

class ScoreView: UIView {
    var delegate: ScoreViewDelegate?
    private var openHeightConstraint: NSLayoutConstraint!
    private var closedHeightConstraint: NSLayoutConstraint!
    
    
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
    }
    
    public final func openView() {
        closedHeightConstraint.isActive = false
        openHeightConstraint.isActive = true
    }
    
    public final func collapseView() {
        closedHeightConstraint.isActive = true
        openHeightConstraint.isActive = false
    }
    
    
    // MARK: - UI
    
    lazy private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-plus"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    lazy private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 22
        return view
    }()
}
