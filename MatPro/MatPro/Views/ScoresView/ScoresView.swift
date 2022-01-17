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
    // MARK: - Private properties
    private var openHeightConstraint: NSLayoutConstraint!
    private var closedHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Public properties
    var delegate: ScoreViewDelegate?
    
    var availableScores: [Score] {
        didSet {
            updateScores()
        }
    }
    
    init(availableScores: [Score]) {
        self.availableScores = availableScores
        super.init(frame: .zero)
        
        setupUI()
        collapseView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateScores() {
        pointsCollectionView.reloadData()
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
    }
    
    private final func openView() {
        closedHeightConstraint.isActive = false
        openHeightConstraint.isActive = true
        pointsCollectionView.isHidden = false
    }
    
    private final func collapseView() {
        closedHeightConstraint.isActive = true
        openHeightConstraint.isActive = false
        pointsCollectionView.isHidden = true
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
    
    lazy private var pointsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        layout.itemSize = CGSize(width: 40, height: 40)
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                  collectionViewLayout: layout)
        let identifier = ScoreCollectionViewCell.identifier
        cv.register(UINib(nibName: identifier , bundle: nil), forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension ScoreView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableScores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = ScoreCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id , for: indexPath) as! ScoreCollectionViewCell
        cell.setupUI(score: availableScores[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
