//
//  MyViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/27.
//

import UIKit
import SwiftyJSON

let ScreenW = UIScreen.main.bounds.size.width
let ScreenH = UIScreen.main.bounds.size.height


class MyViewController: UIViewController {
    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 72, height: 72))
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var incomeView: UIView!
    
    @IBOutlet weak var ggIncome: UILabel!
    @IBOutlet weak var spIncome: UILabel!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var name = "赵贤斌"
    override func viewDidLoad() {
        nameLabel.text = "赵贤斌"
        //设置阴影
        bigView.dropShadow(color: .gray, opacity: 0.7, offSet: CGSize(width: 0, height: 0))
        incomeView.dropShadow(color: .gray, opacity: 0.7, offSet: CGSize(width: 0, height: 0))
        
        
        //设置颜色
        self.headerView.setGradientBackground(colorTop: #colorLiteral(red: 0.8712610006, green: 0.9097581506, blue: 0.9998868108, alpha: 1) , colorBottom: #colorLiteral(red: 0.964926064, green: 0.9803997874, blue: 1, alpha: 1), startPoint: CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint(x: 0.5, y: 1.0))
        
        self.incomeView.setGradientBackground(colorTop: #colorLiteral(red: 0.9948378205, green: 0.9058779478, blue: 0.7236898541, alpha: 1), colorBottom: #colorLiteral(red: 0.9513019919, green: 0.8234592676, blue: 0.5904868841, alpha: 1), startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0))
        //设置部分圆角
        let corners: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.topRight]
        incomeView.corner(byRoundingCorners: corners, radii: 25)
        bigView.layer.cornerRadius = 25
        serviceView.corner(byRoundingCorners: corners, radii: 25)
        
        
        //初始头像
        let image = UIImage(named: "touxiang")
        imageView.image = image
        headView.addSubview(imageView)
        headView.layer.mask = initShape()
        headerView.addSubview(headView)
        
        
        //头像选择方法调用
        let selectPicture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSelectedPicture))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(selectPicture)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let timezone = TimeZone.init(identifier: "Asia/Beijing")
        formatter.timeZone = timezone
        let dateTime = formatter.string(from: Date.init())
        
//        HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/num/getNum",parameters: ["date":"\(dateTime)"]) { result in
//            let value = JSON(rawValue: result)
//            let spincome = value!["data"]["price"].double!
//            self.spIncome.text = "¥ "+String(spincome)
//            print(value!)
//        } failure: { error in
//            print(error)
//        }
//
//        HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/sale/getSale",parameters: ["date":"\(dateTime)"]) { result in
//            let value = JSON(rawValue: result)
//            let cost = value!["data"]["cost"].double!
//            self.ggIncome.text = "¥ "+String(cost)
//            print(value!)
//        } failure: { error in
//            print(error)
//        }
        
    }
    
    
    @IBAction func toDetails(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "toDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destination = segue.destination as! DetailViewController
            destination.name = name
        }
    }
    
    func initShape() -> CAShapeLayer{
        let circleCenter: CGPoint = CGPoint(x: 36, y: 39)
        let circleRadius: CGFloat = 33
        let startAngle: Double = -75.0  // 开始角度
        let endAngle: Double = 255.0    // 结束角度
        let arrowDistance: CGFloat = 6 // 箭头衍生距离
        
        let PI = Double.pi
        let path:UIBezierPath = UIBezierPath.init()
        path.addArc(withCenter: circleCenter, radius: circleRadius, startAngle:  CGFloat(startAngle/180 * PI) , endAngle: CGFloat(endAngle/180 * PI), clockwise: true)
        path.move(to: CGPoint(x: circleCenter.x, y: circleCenter.y - circleRadius - arrowDistance))
        path.addLine(to: CGPoint(x: circleCenter.x + CGFloat(Double(circleRadius) * cos(startAngle/180 * PI)), y: circleCenter.y + CGFloat(Double(circleRadius) * sin(startAngle/180 * PI))))
        path.addLine(to: CGPoint(x: circleCenter.x + CGFloat(Double(circleRadius) * cos(endAngle/180 * PI)), y: circleCenter.y + CGFloat(Double(circleRadius) * sin(endAngle/180 * PI))))
        
        let shapeLayer: CAShapeLayer = CAShapeLayer.init()
        shapeLayer.path = path.cgPath
        return shapeLayer
    }
    
    
}

//MARK: - 头像选择
extension MyViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @objc func didTapSelectedPicture(){
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(.init(title: "取消", style: .cancel))
        alertVC.addAction(.init(title: "相机拍照", style: .default,handler: { [weak self]_ in
            self?.presentCamera()
        }))
        alertVC.addAction(.init(title: "从相册里选取", style: .default,handler: { [weak self]_ in
            self?.presentPhotoPicker()
        }))
        
        present(alertVC,animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc,animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc,animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        self.imageView.image = image
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


    


