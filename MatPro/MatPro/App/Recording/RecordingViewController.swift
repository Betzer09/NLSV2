//
//  RecordingViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit

class RecordingViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var recordingView: UIView!
    
    private let videoAPI = VideoPlayerAPI()
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        videoAPI.configureViewForVideo(recordingView)
    }
    
    // MARK: - View Overrides
    
    // MARK: - Actions
    
    // MARK: - Public methods
    
    // MARK: - Private
}

// MARK: - Orientation
extension RecordingViewController {
    override var shouldAutorotate: Bool {
        setOrientationToLandscape()
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
        
    }
    
    private func setOrientationToLandscape() {
           UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
       }
}

