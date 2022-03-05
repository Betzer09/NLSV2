//
//  FlowRouter.swift
//  MatPro
//
//  Created by Austin Betzer on 3/5/22.
//

import Foundation
import UIKit

/**
 A navigation manager that allows you to navigate to common UI flows within the app.
 */
struct AppFlowManager {
    private init() {}
    
    /**
     Navigation in general should be handled by a coordinator or the presenting view. This is strictly a convenience struct for really common flows.  A few examples would be, navigating to the login flow, in app purchase flow, triggering onboarding flow, etc.
     */
    
    /// Presents the main section of the app
    static func presentMainTab() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first
            
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.window?.rootViewController = Storyboards.main.initialize()
            }
            
        }
    }
}
