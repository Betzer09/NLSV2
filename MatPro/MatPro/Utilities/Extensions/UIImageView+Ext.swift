//
//  UIImageView+Ext.swift
//  AnneCraigFitness
//
//  Created by Austin Betzer on 7/10/21.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {
    public func loadImageFrom(string: String?, placeHolderImage: UIImage? = nil,
                              completion: @escaping SDExternalCompletionBlock = {_,_,_,_  in}) {
        self.sd_setImage(with: URL(string: string ?? ""), placeholderImage: placeHolderImage, completed: completion)
    }
    
    public func loadImageFrom(url: URL?, placeHolderImage: UIImage? = nil,
                              completion: @escaping SDExternalCompletionBlock = {_,_,_,_  in}) {
        self.sd_setImage(with: url, placeholderImage: placeHolderImage, completed: completion)
    }
    
}

extension UIButton {
    public func loadImageFrom(string: String?, placeHolderImage: UIImage? = nil) {
        self.sd_setImage(with: URL(string: string ?? ""), for: .normal, placeholderImage: placeHolderImage)
    }
    
    public func loadImageFrom(url: URL?, placeHolderImage: UIImage? = nil) {
        self.sd_setImage(with: url, for: .normal, placeholderImage: placeHolderImage)
    }
}

