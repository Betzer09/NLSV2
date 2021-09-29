//
//  UIView+Ext.swift
//  AnneCraigFitness
//
//  Created by Drew Carver on 6/30/21.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var vCornerRadius: CGFloat {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var vTopCornerRadius: CGFloat {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var vBorderWidth: CGFloat {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var vBorderColor:UIColor? {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }
        
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
