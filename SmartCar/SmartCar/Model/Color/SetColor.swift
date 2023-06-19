//
//  SetColor.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/4.
//

import UIKit

extension UIView{
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor,startPoint: CGPoint,endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor,colorBottom.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}



