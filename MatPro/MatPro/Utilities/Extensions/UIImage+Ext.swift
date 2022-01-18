//
//  UIImage+Ext.swift
//  AnneCraigFitness
//
//  Created by Drew Carver on 6/19/21.
//

import UIKit

extension UIImage {
    func resize(withWidth newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
