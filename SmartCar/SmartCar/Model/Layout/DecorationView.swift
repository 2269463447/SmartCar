//
//  DecorationView.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/8.
//

import UIKit

class DecorationView: UICollectionReusableView {
    
    fileprivate var bg_imageView = UIImageView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        bg_imageView.frame = bounds
        self.bg_imageView.image = UIImage(named: "bookshelf")
        self.addSubview(bg_imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
       
    }
}
