//
//  AppointmentViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/11.
//

import UIKit
import SwiftyJSON
import AEAlertView
import MapKit

class AppointmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bigView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var formatter = DateFormatter()
    var name = ""
    var index = 0
    
    static var log:[String] = []
    static var location:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigView.layer.cornerRadius = 15
        bigView.addSubview(initLabel())

        pickerView.delegate = self
        pickerView.dataSource = self
        

        pickerView.selectRow(1, inComponent: 0, animated: true)
        
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.string(from: datePicker.date)

        tableView.delegate = self
        tableView.dataSource = self
        
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMap"{
            let destination = segue.destination as! LocationViewController

            destination.flag = false
            destination.index = index
            
            print("111111111111")
            
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        18
    }

    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "补货站"+String(row+1)
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.frame = CGRect(x:40 , y: 0, width: 80, height: 25)
        label.text = "补货站"+String(row+1)
        label.font = .systemFont(ofSize: 17)
        return label
    }
    func initLabel() -> UILabel{
        let label = UILabel()
        label.frame = CGRectMake(10, 85, 353, 1)
        label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7843137255, alpha: 1)
        return label
    }

    
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        formatter.string(from: datePicker.date)
        
    }
    
    @IBAction func tijiao(_ sender: UIButton) {
        
        
        let view = AEAlertView(style: .defaulted)
        view.title = "提示"
        view.message = "提交预约后记得及时补货哦"
        let cancel = AEAlertAction(title: "取消") { action in
            view.dismiss()
        }
        view.addAction(action: cancel)
        
        let confirm = AEAlertAction(title: "确定") { [self] action in
            let dateTime = formatter.string(from: datePicker.date)
            AppointmentViewController.log.append("预约时间：\(dateTime)")
            let row = pickerView.selectedRow(inComponent: 0)
            let str = "补货站"+String(row+1)
            AppointmentViewController.location.append(str)
            tableView.reloadData()
            print(formatter.string(from: datePicker.date))
            print(name)
            view.dismiss()
            
        }
        view.addAction(action: confirm)
        
        view.show()
        
        
        
        
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd"
//        let timezone = TimeZone.init(identifier: "Asia/Beijing")
//        formatter.timeZone = timezone
//        let dateTime = formatter.string(from: Date.init())
//        HttpTool.requestData(.post, URLString: "http://192.168.31.112:12001/appointment/setAppointment",parameters: ["name":name,"date":"\(dateTime)"]) { result in
//            let value = JSON(rawValue: result)
//            if value!["code"].int == 200{
//                AEAlertView.show(title: "提示", message: "申请补货成功", actions: ["ok"]) { action in
//                    }
//            }else{
//                AEAlertView.show(title: "提示", message: "申请补货失败", actions: ["ok"]) { action in
//                    }
//            }
//            print(value!)
//        } failure: { error in
//            AEAlertView.show(title: "提示", message: "申请补货失败", actions: ["ok"]) { action in
//                }
//            print(error)
//        }

        
    }
}

extension AppointmentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppointmentViewController.log.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableID", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row+1).\(AppointmentViewController.log[indexPath.row])"
        cell.detailTextLabel?.text = "地点：\(AppointmentViewController.location[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "预约记录"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let str = cell?.detailTextLabel?.text
        
        let index = str!.index(str!.startIndex, offsetBy: 6)
        let subString = str![index...]
        
        let i = Int(subString)!
        self.index = i-1
        performSegue(withIdentifier: "goMap", sender: self)
        
    }
    
}
