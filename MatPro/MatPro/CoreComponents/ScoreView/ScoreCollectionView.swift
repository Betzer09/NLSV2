//
//  ScoreCollectionView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/17/22.
//

import Foundation
import UIKit

class ScoreCollectionView: UIView {
    private var availablePoints: [PointData] = []
    
    init(availableScores: [PointData]) {
        self.availablePoints = availableScores
        super.init(frame: .zero)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
    
    lazy var pointsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        layout.itemSize = CGSize(width: 40, height: 40)
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                  collectionViewLayout: layout)
        let identifier = PointsCollectionViewCell.identifier
        cv.register(UINib(nibName: identifier , bundle: nil), forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension ScoreCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availablePoints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = PointsCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id , for: indexPath) as! PointsCollectionViewCell
        cell.setupUI(score: availablePoints[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
