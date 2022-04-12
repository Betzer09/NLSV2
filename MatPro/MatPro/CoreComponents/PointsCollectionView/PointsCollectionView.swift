//
//  PointsCollectionView.swift
//  MatPro
//
//  Created by Austin Betzer on 1/19/22.
//

import Foundation
import UIKit

class PointsCollectionView: UIView {
    
    private let scrollDirection: UICollectionView.ScrollDirection
    private var availablePoints: [PointStructure] = []
  
    struct PointsCollectionViewConstants {
        static let horizontalInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let verticalInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    init(scrollDirection: UICollectionView.ScrollDirection) {
        self.scrollDirection = scrollDirection
        super.init(frame: .zero)
        
        addSubview(pointsCollectionView)
        pointsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pointsCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pointsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pointsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pointsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var pointsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.sectionInset = scrollDirection == .horizontal ? PointsCollectionViewConstants.horizontalInsets : PointsCollectionViewConstants.verticalInsets
        layout.itemSize = CGSize(width: 40, height: 40)
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        let identifier = PointsCollectionViewCell.identifier
        cv.register(UINib(nibName: identifier , bundle: nil), forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func reloadCollectionView(with pointData: [PointStructure]) {
        self.availablePoints = pointData
        reloadCollectionView()
    }
    
    private func reloadCollectionView() {
        pointsCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension PointsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
