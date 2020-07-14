//
//  KSBGradientView.swift
//  KSBGradientView
//
//  Created by Sai Balaji on 12/07/20.
//

import Foundation


extension UIView
{
   public func applyVerticalGradient(startcolor color1: UIColor,endcolor color2: UIColor)
    {
        
        let glayer = CAGradientLayer()
        glayer.colors = [color1.cgColor,color2.cgColor]
        
        glayer.frame = bounds
        
        layer.insertSublayer(glayer, at: 0)
        
    }
    
    
    public func applyHorizontalGradient(startcolor color1: UIColor,endcolor color2: UIColor)
    {
        let glayer = CAGradientLayer()
        glayer.colors = [color1.cgColor,color2.cgColor]
        glayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        glayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        glayer.frame = bounds
        
        layer.insertSublayer(glayer, at: 0)
    }
}
