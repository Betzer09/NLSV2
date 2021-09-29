//
//  UITapGesture+Ext.swift
//  AnneCraigFitness
//
//  Created by Austin Betzer on 8/5/21.
//

import Foundation
import UIKit


extension UITapGestureRecognizer {
    func didTapAttributedTextInTextView(textView: UITextView, inRange targetRange: NSRange) -> Bool {
        let layoutManager = textView.layoutManager
        let locationOfTouch = self.location(in: textView)
        let index = layoutManager.characterIndex(for: locationOfTouch, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(index, targetRange)
    }
}
