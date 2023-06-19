//
//  ViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/28.
//

import UIKit


class DetailViewController: UIViewController {
    

    var name = ""
    var labels = ["姓名", "姓名", "微信公众号", "电话", "去评分", "用户协议", "iOS开发", "版本更新", "4G/5G", "非Wifi", ]
    var detialLabels = ["445-66888-333", "赵贤斌", "grbank", "19858591680", "1-5", "5个", "Alex", "V.1.0", "4G", ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        detialLabels[1] = name
        

        
//        title = "UITableViewCell测试";
        let size = UIScreen.main.bounds.size
        
        
        let frame = CGRect(x: 0, y: 95, width: self.view.frame.size.width, height: self.view.frame.size.height - 64)
        let tableView = UITableView.init(frame: frame, style: .plain)
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        
        let footer = UIView()
        footer.backgroundColor = UIColor.white
        tableView.tableFooterView = footer
        
        // 添加header
        let headFrame = CGRect(x: 0, y: 0, width: size.width, height: 150)
        tableView.wg_setHeaderView(frame: headFrame, image: UIImage.init(named: "背景"))
    }
}

// MARK: UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CELLID = "CELLID"
        var cell = tableView.dequeueReusableCell(withIdentifier: CELLID)
        if cell == nil {
            
            cell = UITableViewCell(style: .value1, reuseIdentifier: CELLID)
            cell?.textLabel?.text = labels[indexPath.row]
            cell?.detailTextLabel?.text = detialLabels[indexPath.row]
        }
        
        return cell!
    }
}


// MARK: UITableViewDelegate
extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("你点击了第\(indexPath.row)个cell")
    }
}
