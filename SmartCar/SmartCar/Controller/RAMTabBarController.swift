//
//  RAMTabBarController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/12.
//

import UIKit
import RAMAnimatedTabBarController

class RAMTabBarController: RAMAnimatedTabBarController {

    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = self.viewControllers![0] as! HomeViewController
        vc.name = name
        let my = self.viewControllers![2] as! MyViewController
        my.name = name
        
//        vc.name = name

        
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
