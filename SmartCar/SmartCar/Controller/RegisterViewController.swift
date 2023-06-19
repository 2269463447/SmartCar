//
//  ViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/14.
//

import UIKit
import RAMAnimatedTabBarController
import SwiftyJSON
import AEAlertView

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var textfield1: UIImageView!
    @IBOutlet weak var textfield2: UIImageView!
    
    @IBOutlet weak var textfield3: UIImageView!
   
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.setBorderColorFromUIColor(color: #colorLiteral(red: 0.6359565258, green: 0.6309315562, blue: 0.8713409901, alpha: 1))
        
        textfield1.addSubview(initLabel())
        textfield2.addSubview(initLabel())
        textfield3.addSubview(initLabel())
    }
    
    func initLabel() -> UILabel{
        let label = UILabel()
        label.frame = CGRectMake(117, 23, 2, 30)
        label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return label
    }
    
    
    
    @IBAction func clickButton(_ sender: UIButton) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func gotoLogin(_ sender: UIButton) {
//        HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/user/insertUser",parameters: ["phoneNumber":"\(phoneNumber.text!)","password":"\(password.text!)","name":"\(name.text!)"]) { result in
//            let value = JSON(rawValue: result)
//            if value!["code"].int == 200{
//                AEAlertView.show(title: "提示", message: "注册成功 前往登陆", actions: ["cancel", "ok"]) { action in
//                    self.performSegue(withIdentifier: "login", sender: self)
//                }
//                print(value!)
//            }
//        } failure: { error in
//            print(error)
//        }

        self.performSegue(withIdentifier: "login", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let destination = segue.destination as! LoginViewController
            destination.name = name.text!
        }
    }
}

