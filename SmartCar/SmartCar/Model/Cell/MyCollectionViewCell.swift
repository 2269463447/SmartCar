//
//  MyCollectionViewCell.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/6/17.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    
    public var textLabel: UILabel!
    
    public var subLabel: TextUpperLeftLabel!
    
    public var distanceLabel: UILabel!
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel()
        textLabel.frame = CGRect(x: 10, y: 10, width: 80, height: 20)
        textLabel.font = .boldSystemFont(ofSize: 15)
        contentView.addSubview(textLabel)
        
        
        subLabel = TextUpperLeftLabel()
        subLabel.textColor = .gray
        subLabel.frame = CGRect(x: 10, y: 40, width: 230, height: 80)
        subLabel.numberOfLines = 0
        
        subLabel.font = .systemFont(ofSize: 13)
        contentView.addSubview(subLabel)
        contentView.addSubview(initLabel())
        contentView.addSubview(initImage())
        contentView.addSubview(initImage2())
        contentView.addSubview(initImage3())
        
        
        distanceLabel = UILabel()
        distanceLabel.frame = CGRect(x: 270, y: 30, width: 100, height: 30)
        distanceLabel.font = .systemFont(ofSize: 13)
        distanceLabel.textColor = .gray
        contentView.addSubview(distanceLabel)
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
    
    // 设置选中背景色
    override var isSelected: Bool {
        didSet {
            contentView.layer.cornerRadius = 15
            contentView.layer.borderWidth = 2
            if isSelected {
                contentView.layer.setBorderColorFromUIColor(color: .orange)
            } else {
                contentView.layer.setBorderColorFromUIColor(color: .white)
            }
            super.isSelected = isSelected
        }
    }
    
    // 设置高亮色
//    override var isHighlighted: Bool {
//        didSet {
//            if isHighlighted {
//                contentView.backgroundColor = .purple
//            } else {
//                contentView.backgroundColor = nil
//            }
//            super.isHighlighted = isHighlighted
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func addLocation( title:String, subtitle:String, distance: Float) -> UIView {
//        let locationView = UIView(frame: CGRect(x: 5, y: 5, width: 330, height: 130))
//        locationView.addSubview(initTitleLabel(title: title))
//        locationView.addSubview(initSubLabel(subtitle: subtitle))
//        locationView.addSubview(initLabel())
//        locationView.addSubview(initImage())
//        locationView.addSubview(initImage2())
//        locationView.addSubview(initImage3())
//        locationView.addSubview(initDistance(distance: distance))
//        locationView.backgroundColor = .white
//        return locationView
//    }
    func initLabel() -> UILabel{
        let label = UILabel()
        label.frame = CGRectMake(250, 15, 1, 110)
        label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return label
    }
//    func initTitleLabel(title:String) -> UILabel{
//        let label = UILabel()
//        label.frame = CGRect(x: 10, y: 10, width: 80, height: 20)
//        label.text = title
//        label.font = .boldSystemFont(ofSize: 15)
//        return label
//    }
//    func initSubLabel(subtitle:String) -> TextUpperLeftLabel{
//        let sublabel = TextUpperLeftLabel()
//        sublabel.textColor = .gray
//        sublabel.frame = CGRect(x: 10, y: 35, width: 230, height: 80)
//        sublabel.numberOfLines = 0
//        sublabel.text = "\(subtitle)\n\n营业时间：8:30-21:30"
//        sublabel.font = .systemFont(ofSize: 13)
//        return sublabel
//    }
    func initDistance(distance: Float) -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 270, y: 35, width: 100, height: 30)
        let jl = String(format:"%.1f",distance)
        label.text = "距离\(jl)km"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }
    func initImage() -> UIImageView{
        let imageView = UIImageView(frame: CGRect(x: 10, y: 105, width: 44, height: 20))
        imageView.image = UIImage(named: "营业中")
        return imageView
    }
    func initImage2() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 272, y: 75, width: 22, height: 22))
        imageView.image = UIImage(named: "定位点")
        return imageView
    }
    func initImage3() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 310, y: 75, width: 22, height: 22))
        imageView.image = UIImage(named: "电话")
        return imageView
    }
    
}
