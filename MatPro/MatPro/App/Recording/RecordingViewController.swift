//
//  RecordingViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit

class RecordingViewController: SwiftyCamViewController {
    // MARK: - Outlets
    
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
//        UIUtils.lockOrientation(.landscapeLeft, andRotateTo: .landscapeLeft)
    }

    
    // MARK: - View Overrides
    
    // MARK: - Actions
    
    // MARK: - Public methods
    
    // MARK: - Private
    
    
    private func setupCamera() {
        cameraDelegate = self
        defaultCamera = .rear
        videoGravity = .resizeAspectFill
        shouldPrompToAppSettings = true
        shouldUseDeviceOrientation = true
        audioEnabled = false
        flashMode = .off
        doubleTapCameraSwitch = false
    }
}

extension RecordingViewController: SwiftyCamViewControllerDelegate {
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        
    }
    
}

// MARK: - Orientation
extension RecordingViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

