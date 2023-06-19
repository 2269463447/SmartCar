//
//  LoginViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/16.
//

import UIKit
import RAMAnimatedTabBarController
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textfield1: UIImageView!
    @IBOutlet weak var textfield2: UIImageView!
    
    var name = ""
    
    
    var flag:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.isHidden = flag
        register.isHidden = flag
        
        
        button.layer.setBorderColorFromUIColor(color:#colorLiteral(red: 0.6359565258, green: 0.6309315562, blue: 0.8713409901, alpha: 1) )
        let item = UIBarButtonItem(title: "登录", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        
        textfield1.addSubview(initLabel())
        textfield2.addSubview(initLabel())
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    
    
    func initLabel() -> UILabel{
        let label = UILabel()
        label.frame = CGRectMake(117, 34, 2, 39)
        label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return label
    }
    
    
    
    @IBAction func goToRegister(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        let flag = shouldPerformSegue(withIdentifier: "success", sender: self)
        if flag == true{
//            HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/user/login",parameters: ["phoneNumber":"\(usernameTextField.text!)","password":"\(passwordTextField.text!)"]) { result in
//                let value = JSON(rawValue: result)
//                if value!["code"].int == 200{
//                    self.name = value!["data"]["name"].string!
//                    print(value!)
//                    self.performSegue(withIdentifier: "success", sender: self)
//                }else if value!["code"].int == 400{
//                    self.errorLabel.text = "用户名或密码不正确"
//                }else{
//                    self.errorLabel.text = "账号不存在"
//                }
//
//                print(result)
//            } failure: { error in
//                print(error)
//            }
            self.performSegue(withIdentifier: "success", sender: self)
        }

    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "success" {
            let destination = segue.destination as! RAMTabBarController
            destination.navigationItem.hidesBackButton = true
            destination.name = name
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "success"{
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            if username.isEmpty{
                errorLabel.text = "账号不能为空"
                return false
            }
            if password.isEmpty{
                errorLabel.text = "密码不能为空"
                return false
            }
            errorLabel.text = nil
        }
        return true
    }
}


extension LoginViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
}
