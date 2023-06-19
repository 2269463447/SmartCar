//
//  BaseFooterView.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/6.
//

import UIKit

class BaseFooterView: UICollectionReusableView {
    
    private var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textAlignment = .center
        textLabel.text = "特价出售"
        self.addSubview(textLabel)
        self.setGradientBackground(colorTop: #colorLiteral(red: 0.9948378205, green: 0.9058779478, blue: 0.7236898541, alpha: 1), colorBottom: #colorLiteral(red: 0.9513019919, green: 0.8234592676, blue: 0.5904868841, alpha: 1), startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds
    }
}
