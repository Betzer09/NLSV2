//
//  UIInterfaceOrientation.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit
import AVFoundation

extension UIInterfaceOrientation {

  public var videoOrientation: AVCaptureVideoOrientation {
    switch self {
    case .portrait:
      return AVCaptureVideoOrientation.portrait
    case .landscapeRight:
      return AVCaptureVideoOrientation.landscapeRight
    case .landscapeLeft:
      return AVCaptureVideoOrientation.landscapeLeft
    case .portraitUpsideDown:
      return AVCaptureVideoOrientation.portraitUpsideDown
    default:
      return AVCaptureVideoOrientation.portrait
    }
  }

}
