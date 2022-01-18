//
//  UIFont+Ext.swift
//  AnneCraigFitness
//
//  Created by Austin Betzer on 8/5/21.
//

import Foundation
import UIKit

/**
 This extension should hold all of the available fonts
 */
extension UIFont {
    
    // MARK: - Inter Fonts(Apps new Main font)
    class func proximaNovaBold(ofSize fontSize: CGFloat) -> UIFont {
        guard let font =  UIFont(name: "ProximaNova-Bold", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
    
    class func proximaNovaRegular(ofSize fontSize: CGFloat) -> UIFont {
        guard let font =  UIFont(name: "ProximaNova-Regular", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
    
    class func proximaNovaSemiBold(ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "ProximaNova-Semibold", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
    
    // MARK: - Inter Fonts(Apps new Main font)
    class func dinCondensedRegular(ofSize fontSize: CGFloat) -> UIFont {
        guard let font =  UIFont(name: "DINCondensed-Regular", size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
    
    
}

