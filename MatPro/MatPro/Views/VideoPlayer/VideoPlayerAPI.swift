//
//  VideoPlayerAPI.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit
import AVFoundation


class VideoPlayerAPI: NSObject {
    
    private(set) var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private(set) var session: AVCaptureSession
    
    override init() {
        session = AVCaptureSession()
        super.init()
    }
    
    // MARK: - init
    public func configureViewForVideo(_ view: UIView) throws {
        try setupSession(for: view)
    }
    
    
    private func setupSession(for previewView: UIView) throws {
        session.sessionPreset = .high
        
        guard let backCamera =  AVCaptureDevice.default(for: .video) else {
            throw VideoAPIError.unableToSetupBackCamera
        }
        
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
            
            guard session.canAddInput(input) else {return}
            session.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = .resizeAspect
            videoPreviewLayer!.connection?.videoOrientation = .portrait
            previewView.layer.addSublayer(videoPreviewLayer!)
            session.startRunning()
            
        } catch let error as NSError {
            throw VideoAPIError.some(error)
        }
    }
    
    enum VideoAPIError: Error {
        case unableToSetupBackCamera
        case some(Error)
        
        var description: String {
            switch self {
            case .unableToSetupBackCamera:
                return "We were unable to set up the back camera."
            case .some(let error):
                return error.localizedDescription
            }
        }
    }
    
    
}
