//
//  HttpTool.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/4/9.
//

import UIKit
import Alamofire
import SwiftyJSON


enum MothodType {
    case get
    case post
}

class HttpTool: NSObject {

}
extension HttpTool{
    
    /// 网络请求通用版
    /// - Parameters:
    ///   - type: 数据请求方式 get/post
    ///   - URLString: 请求数据的路径
    ///   - paramaters: 请求数据需要的参数
    class func requestData(_ type : MothodType, URLString : String, parameters : [String : Any]? = nil, success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        //  获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //  发送网络请求
        AF.request(URLString, method: method, parameters: parameters, encoding: JSONEncoding.default,headers:[:]).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
