//
//  HomeViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/17.
//

import UIKit
import SwiftCharts
import AEAlertView
import SwiftyJSON

class HomeViewController: UIViewController {

    private let cellID = "baseCellID"
    var collectionView: UICollectionView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var setTitle: UILabel!
    
    @IBOutlet weak var goodsButton: UIButton!
    
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var advertisementView: UIView!
    
    var name = ""
    var yinliaonr = ["美年达","农夫山泉","魔爪","阿萨姆奶茶","冰红茶"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle.text = "随手买随车智能营销平台"
        
        let frame = CGRect(x: 0, y: 444, width: 361, height: 300)
        let goodsView = UIView.init(frame: frame)
        goodsView.backgroundColor = .white
        scrollView.addSubview(goodsView)
        scrollView.showsVerticalScrollIndicator = false
        //设置圆角阴影
        bigView.dropShadow(color: .gray, opacity: 0.05, offSet: CGSize(width: 0, height: 0))
        bigView.layer.cornerRadius = 25
        bigView.addSubview(initLabel())
        setUpView(view: bigView)
        
        advertisementView.dropShadow(color: .gray, opacity: 0.05, offSet: CGSize(width: 0, height: 0))
        advertisementView.layer.cornerRadius = 25
        addTitle(title: "我的广告", view: advertisementView,font: 17, color: .black)
        let adView = UIView.init(frame: CGRect(x: 10, y: 45, width: 341, height: 90))
        adView.backgroundColor = #colorLiteral(red: 0.3290227354, green: 0.3869941235, blue: 0.892972827, alpha: 1)
        adView.layer.cornerRadius = 15
        adView.addSubview(addTime())
        addImage(name: "广告", view: adView, location: CGRect(x: 45, y: 40, width: 35, height: 35))
        addTitle(title: "今日播放时间", view: adView, font: 14, color: .white)
        let timeLabel = UILabel(frame: CGRect(x: 110, y: 40, width: 120, height: 30))
        timeLabel.font = .boldSystemFont(ofSize: 15)
        timeLabel.textColor = .white
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let timezone = TimeZone.init(identifier: "Asia/Beijing")
        formatter.timeZone = timezone
        let dateTime = formatter.string(from: Date.init())
        
        
        HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/sale/getSale",parameters: ["date":"\(dateTime)"]) { result in
            let value = JSON(rawValue: result)
//            let time = value!["data"]["time"].int!
//            timeLabel.text = self.transToHourMinSec(time: time)
            print(value!)
        } failure: { error in
            print(error)
        }
        
        adView.addSubview(timeLabel)
        
        
        
        
        
        let button = UIButton(frame: CGRect(x: 275, y: 9, width: 70, height: 27))
        button.backgroundColor = #colorLiteral(red: 0.3290227354, green: 0.3869941235, blue: 0.892972827, alpha: 1)
        button.setTitle("广告开启", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action:#selector(self.btnClick(_:)) , for: .touchUpInside)
        
        advertisementView.addSubview(button)
        advertisementView.addSubview(adView)
        
        
        
        goodsView.dropShadow(color: .gray, opacity: 0.05, offSet: CGSize(width: 0, height: 0))
        goodsView.layer.cornerRadius = 25
        addTitle(title: "剩余商品", view: goodsView,font: 17, color: .black)
        
        
        //设置scrollView
//        let corners: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.topRight]
//        scrollView.corner(byRoundingCorners: corners, radii: 25)
        scrollView.layer.cornerRadius = 25
        scrollView.contentSize = CGSizeMake(361, 750)
        scrollView.delegate = self
        scrollView.bounces = false
        
        //设置bigView
        addImage(name: "营销数据", view: bigView, location: CGRect(x: 25, y: 15, width: 100, height: 20))
        addImage(name: "柱状图", view: bigView, location: CGRect(x: 130, y: 13, width: 23, height: 22))
        
        
        
        
        
        HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/num/getNum",parameters: ["date":"\(dateTime)"]) { result in
            let value = JSON(rawValue: result)
            let name = value!["data"]["numList"]
            let number = value!["data"]["numList"].count - 1
            for i in 0...number{
                if i <= 2{
                    let imageView = UIImageView(frame: CGRect(x: 10+110*i, y: 40, width: 70, height: 80))
                    imageView.image = UIImage(named: name[i]["name"].string!)
                    let label = UILabel(frame: CGRect(x: 75+110*i, y: 60, width: 70, height: 30))
                    label.text = "余量:"+String(name[i]["num"].int!)
                    label.font = .systemFont(ofSize: 13)
                    goodsView.addSubview(imageView)
                    goodsView.addSubview(label)
                }else if i <= 5{
                    let imageView = UIImageView(frame: CGRect(x: 10+110*(i-3), y: 135, width: 70, height: 80))
                    imageView.image = UIImage(named: name[i]["name"].string!)
                    let label = UILabel(frame: CGRect(x: 75+110*(i-3), y: 155, width: 70, height: 30))
                    label.text = "余量:"+String(name[i]["num"].int!)
                    label.font = .systemFont(ofSize: 13)
                    goodsView.addSubview(imageView)
                    goodsView.addSubview(label)
                }
                
            }
            print(value!)
        } failure: { error in
            print(error)
        }





        
    }
    
    
    
    
    
    @IBAction func goShop(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goShop", sender: self)
    }
    

    
    

}
//MARK: - CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseCollectionViewCell
        cell.cellIndex = indexPath.item
        cell.backgroundColor = #colorLiteral(red: 0.9569018483, green: 0.9568391442, blue: 0.9732491374, alpha: 1)
        cell.layer.cornerRadius = 25
        let image = UIView(frame: CGRect(x: 0, y: 0, width: 141, height: 180))
        image.backgroundColor = .white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 145, height: 180))
        imageView.image = UIImage(named: "1")
        let yinliao = UIImageView(frame: CGRect(x: 40, y: 48, width: 80, height: 110))
        yinliao.image = UIImage(named: yinliaonr[indexPath.item])
        let label = UILabel()
        label.frame = CGRect(x: 40, y: 13, width: 110, height: 30)
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "热销 Top \(indexPath.item+1)"
        label.textColor = #colorLiteral(red: 0.3634179831, green: 0.2192165852, blue: 0.1350669861, alpha: 1)
        imageView.addSubview(label)
        image.addSubview(imageView)
        image.addSubview(yinliao)
        cell.addSubview(image)
        return cell
    }
    
}
//MARK: - 方法
extension HomeViewController {
    func initLabel() -> UILabel{
        let label = UILabel()
        label.frame = CGRectMake(28, 50, 305, 1)
        label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return label
    }
    func setUpView(view:UIView){
        let layout = CoverFlowLayout()
        let margin: CGFloat = 10
        let collH: CGFloat = 200
        let itemH = collH - margin * 2
        let itemW = view.bounds.width - margin * 2 - 200
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.scrollDirection = .horizontal
        
        // 初始化 collectionview
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 60, width: view.bounds.width, height: collH), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        // 注册 Cell
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView)
    }
    
    func addTitle(title:String,view:UIView,font:Int,color:UIColor){
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 7, width: 110, height: 30)
        label.text = title
        label.textColor = color
        label.font = .boldSystemFont(ofSize: CGFloat(font))
        view.addSubview(label)
    }
    func addImage(name:String,view:UIView,location:CGRect){
        let imageView = UIImageView(frame: location)
        imageView.image = UIImage(named: name)
        view.addSubview(imageView)
    }
    
    func addTime() -> UILabel{
        let label = UILabel()
        label.frame = CGRect(x: 240, y: 7, width: 150, height: 30)
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let timezone = TimeZone.init(identifier: "Asia/Beijing")
        formatter.timeZone = timezone
        let dateTime = formatter.string(from: Date.init())
        label.text = dateTime
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }
    func test() {
        
        // set background image
        AEAlertView.show(title: "title", message: "set background image", actions: ["cancel", "ok"], bgImage: UIImage(named: "006")) { action in
            print("dismiss----background")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yuyue" {
            let destination = segue.destination as! AppointmentViewController
            destination.name = name
        }
    }
    @objc func btnClick(_ sender: UIButton){
        if sender.currentTitle  == "广告开启" {
            sender.setTitle("广告关闭", for: .normal)
            sender.backgroundColor = .gray
            AEAlertView.show(title: "提示", message: "广告已关闭", actions: ["ok"]) { action in
                    print("dismiss----Fastest")
                }
        } else {
            sender.setTitle("广告开启", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.3290227354, green: 0.3869941235, blue: 0.892972827, alpha: 1)
            AEAlertView.show(title: "提示", message: "广告已开启", actions: ["ok"]) { action in
                    print("dismiss----Fastest")
                }
        }
    }
    
    //时间转换
    func transToHourMinSec(time: Int) -> String
    {
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = time / 3600
        hoursText = hours > 9 ? "\(hours)" : "\(hours)"
        
        minutes = time % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "\(minutes)"
        
        seconds = time % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "\(seconds)"
        
        return "\(hoursText)时\(minutesText)分\(secondsText)秒"
    }
}
