//
//  CALayerCateGories.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/16.
//

import Foundation
import UIKit


extension CALayer{
    func setBorderColorFromUIColor(color:UIColor){
        self.borderColor = color.cgColor
    }
}
