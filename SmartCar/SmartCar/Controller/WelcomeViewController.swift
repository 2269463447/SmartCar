//
//  WelcomeViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/14.
//

import UIKit
import CLTypingLabel
import QuartzCore
import LTMorphingLabel

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: LTMorphingLabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.setBorderColorFromUIColor(color: .white)
        titleLabel.pause()
        titleLabel.text = "Smart   Market"
        titleLabel.morphingEffect = LTMorphingEffect.pixelate
        titleLabel.updateProgress(progress: 0.0)

        let item = UIBarButtonItem(title: "主页", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLogin"{
            let destination = segue.destination as! LoginViewController
            destination.flag = true
        }
    }

}



//MARK: - <#Section Heading#>
