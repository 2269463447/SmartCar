//
//  ViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/6.
//

import UIKit

class BaseAPIViewController: UIViewController {

    fileprivate var collectionView: UICollectionView!
    let shop:[String] = ["阿萨姆奶茶","无糖可乐","百岁山","餐巾纸","冰红茶","芬达","可乐","口罩","酷儿","李子园","美年达","魔爪","农夫山泉","无糖雪碧","雪碧","怡宝","益达"]
    let sellPrice:[String] = ["4","3.5","3","1","3","3","3","1","4","4","3","3","2","3","3","2","6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "所有商品"
        
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 30
        let section: CGFloat = 15
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: section, left: margin, bottom: section, right: margin)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.sectionFootersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 393, height: 780), collectionViewLayout: flowLayout)
        // 注册 Cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        // 注册头部视图
        collectionView.register(BaseHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        // 注册尾部视图
        collectionView.register(BaseFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .white
    }
//        func initText(cell:UICollectionViewCell,text:String){
//            let label = UILabel()
//            label.frame = CGRectMake(15, cell.bounds.height*0.7+15, 155, 30)
//            label.text = text
//            cell.addSubview(label)
//        }
        func initLabel(cell:UICollectionViewCell){
            let label = UILabel()
            label.frame = CGRectMake(5, cell.bounds.height*0.7 , 140, 2)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
            cell.addSubview(label)
        }
}


extension BaseAPIViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 返回 cell 尺寸
        return CGSize(width: 150, height: 220)
    }
}

extension BaseAPIViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension BaseAPIViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shop.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.dropShadow(color: .gray, opacity: 0.5, offSet: CGSize(width: 0, height: 0))
        let imageView = UIImageView(frame: CGRect(x: 30, y: 15, width: 90, height: 120))
        imageView.image = UIImage(named: "\(shop[indexPath.item])")
        let textView = UIView(frame: CGRect(x: 0, y: 155, width: 150, height: 50))
        textView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 0, width: 150, height: 50)
        label.numberOfLines = 2
        label.text = "\(shop[indexPath.item])\n零售价：\(sellPrice[indexPath.item])"
        textView.addSubview(label)
        cell.addSubview(imageView)
        cell.addSubview(textView)
        initLabel(cell: cell)
//        initText(cell: cell, text: "\(shop[indexPath.item])")
        return cell
    }
    
    // 返回追加视图对象，供 UICollectionView 加载
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: BaseHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! BaseHeaderView
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: BaseFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath) as! BaseFooterView
            return footerView
        }

        return UICollectionReusableView()
    }
    
    // 返回追加视图尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }

    // 返回
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
}
