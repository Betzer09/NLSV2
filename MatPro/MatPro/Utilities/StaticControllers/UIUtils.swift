//
//  UIUtils.swift
//  AnneCraigFitness
//
//  Created by Austin Betzer on 7/23/21.
//

import Foundation
import UIKit


/**
 This class is used to create reusable UI components that are shared across multiple screens. For example
 custom alerts, xib presentations, etc
 */
class UIUtils {
    
    private init() {}
    
    /**
     Assists with locking orientation
     
     - parameter orientation: Desired orientation our app supports
     */
    
    class func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.supportedOrientation = orientation
        }
    }
    
    /// Added method to adjust lock and rotate to the desired orientation
    class func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

// MARK: - App Navigation

/**
 Storyboards that are in the consumer app
 */
public enum Storyboards: String {
    /// The root tab bar
    case main
    case match
    
    /**
     Creates a storyboard instance
     - parameter storyboardName: The name of the storyboard name
     */
    func initialize(storyboardName: String? = nil) -> UIViewController {
        if let name = storyboardName {
            return UIStoryboard(name: "\(self)".capitalizingFirstLetter(), bundle: nil).instantiateViewController(withIdentifier: name)
        } else {
            return UIStoryboard(name: "\(self)".capitalizingFirstLetter(), bundle: nil).instantiateInitialViewController()!
        }
    }
}
