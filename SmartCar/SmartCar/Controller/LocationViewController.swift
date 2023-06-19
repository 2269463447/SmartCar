//
//  LocationViewController.swift
//  SmartCar
//
//  Created by 赵贤斌 on 2023/3/17.
//

import UIKit
import MapKit
import SwiftyJSON


@objcMembers
class LocationViewController: UIViewController, UIScrollViewDelegate, MKMapViewDelegate{
    
    
    @IBOutlet weak var locationScrollView: UIScrollView!
    
    @IBOutlet weak var map: MKMapView!
    var flag = true
    var index:Int = 0
    
    @IBOutlet weak var locationButton: UIButton!
    var location:[(String,String,CLLocationDegrees,CLLocationDegrees)] = [("补货站1","补货站11111111",30.1,120.48),("补货站2","补货站11111111",30.11,120.5),("补货站3","补货站11111111",29.12,119.17),("补货站4","补货站11111111",30.25,119.16),("补货站5","补货站11111111",30.05,120.50),("补货站6","补货站11111111",30.05,120.48),("补货站7","补货站11111111",30.33,120.56),("补货站8","补货站11111111",30.25,120.46),("补货站9","补货站11111111",30.44,119.16),("补货站10","补货站11111111",29.89,119.16),("补货站11","补货站11111111",29.25,119.16),("补货站12","补货站11111111",29.89,120.36),("补货站13","补货站11111111",30.25,120.56),("补货站14","补货站11111111",30.103,120.466),("补货站15","补货站11111111",29.25,121.56),("补货站16","补货站11111111",30.09,120.455),("补货站17","补货站11111111",29.25,117.16),("补货站18","补货站11111111",30.08,120.46)]
    //    typealias MKPositioningClosure = (String) -> ()
    //    var clousre : MKPositioningClosure?
    
    var locationManager = CLLocationManager()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        //        HttpTool.requestData(.get, URLString: "http://192.168.31.112:12001/stock/all") { result in
        //            let value = JSON(rawValue: result)
        //            print(value!["data"].count)
        //            let number = value!["data"].count-1
        //            self.locationScrollView.contentSize = CGSizeMake(ScreenW, CGFloat((number+1)*150+10))
        //            for i in 0...number{
        //                let name = value!["data"][i]
        //                print(value!["data"][i])
        //                self.location.append((name["name"].string!,name["address"].string!,name["latitude"].double!,name["longitude"].double!))
        //                self.collectionView.reloadData()
        //                self.locationScrollView.reloadInputViews()
        //                self.initAnnotationData(name["name"].string!,name["address"].string!,name["latitude"].double!,name["longitude"].double!)
        //
        //            }
        //            self.collectionView.reloadData()
        //        } failure: { error in
        //            print(error)
        //        }
        
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        self.map.showsUserLocation = true
        self.map.userLocation.title = "我的位置"
        self.map.delegate = self
        map.userTrackingMode = .followWithHeading
        
        self.map.mapType = .standard
        if(flag){
            let lat = locationManager.location!.coordinate.latitude
            let lon = locationManager.location!.coordinate.longitude
            
            let location1 = CLLocation(latitude: lat, longitude: lon)
            let viewRegion = MKCoordinateRegion(center: location1.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            map.setRegion(viewRegion, animated: true)
            print("2222222")
        }else{
            let location1 = CLLocation(latitude: self.location[index].2, longitude: self.location[index].3)
            let viewRegion = MKCoordinateRegion(center: location1.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            map.setRegion(viewRegion, animated: true)
            print("传值成功")
            map.userTrackingMode = .none
        }
        
        locationButton.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        
        
        
        locationManager.delegate = self    //要放在前面
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()    //请求位置信息/如果一直获取用startUpdatingLocation()
        
    
        locationScrollView.bounces = false
        locationScrollView.showsVerticalScrollIndicator = false

        
        locationScrollView.delegate = self
        
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //MARK: - 集合视图
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 358, height: 140)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: flowLayout)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9569018483, green: 0.9568391442, blue: 0.9732491374, alpha: 1)
        
        locationScrollView.addSubview(collectionView)
        
        
        
        var contentRect = CGRectZero
        for view in self.locationScrollView.subviews {
            contentRect = CGRectUnion(contentRect, view.frame)
        }
        self.locationScrollView.contentSize = contentRect.size
        
        
        //MARK: - 绘制标记点
        for i in 0...self.location.count-1{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.location[i].2, longitude: self.location[i].3)
            annotation.title = self.location[i].0
            annotation.subtitle = self.location[i].1
            self.map.addAnnotation(annotation)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        locationButton.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        print("视图消失")
    }
    
    
    
    
    
    @IBAction func location(_ sender: UIButton) {
        locationManager.requestLocation()
        let lat = locationManager.location!.coordinate.latitude
        let lon = locationManager.location!.coordinate.longitude
        let location = CLLocation(latitude: lat, longitude: lon)
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        map.setRegion(viewRegion, animated: true)
        
        
        map.setUserTrackingMode(.followWithHeading, animated: true)
//        mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: lon), animated: true)
    }
    
    
    //MARK: - 实现MKMapViewDelegate协议
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
    }
    
    

//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let lat = locationManager.location!.coordinate.latitude
//        let lon = locationManager.location!.coordinate.longitude
//        let location = CLLocation(latitude: lat, longitude: lon)
//        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
//        if(mapView.region.center.latitude == viewRegion.center.latitude){
//            locationButton.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
//        }
//        else{
//            locationButton.tintColor = .gray
//        }
//    }
    
    

    
}




//MARK: - 获取定位点信息
extension LocationViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            //            mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: lon), animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


extension LocationViewController: UICollectionViewDelegate {
    
}
extension LocationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return location.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! MyCollectionViewCell
        locationManager.requestLocation()
        
        //获取定位
        let lat = locationManager.location!.coordinate.latitude
        let lon = locationManager.location!.coordinate.longitude
        
        let point1 = MKMapPoint(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        let point2 = MKMapPoint(CLLocationCoordinate2D(latitude: location[indexPath.item].2, longitude: location[indexPath.item].3))
        
        let distance = point1.distance(to: point2)
        let distance2 = distance/1000
        let jl = String(format:"%.1f",distance2)
        cell.distanceLabel.text = "距离\(jl)km"
//        let point1 = MAMapPointForCoordinate(CLLocationCoordinate2D(latitude: lat, longitude: lon))
//        let point2 = MAMapPointForCoordinate(CLLocationCoordinate2D(latitude: location[indexPath.item].2, longitude: location[indexPath.item].3))
//
//        //2.计算距离
//        let distance = MAMetersBetweenMapPoints(point1,point2);
//        let distance2 = distance/1000
//        
//        let jl = String(format:"%.1f",distance2)
//        cell.distanceLabel.text = "距离\(jl)km"
        
        cell.textLabel.text = "\(location[indexPath.item].0)"
        cell.subLabel.text = "\(location[indexPath.item].1)\n\n营业时间：8:30-21:30"

        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.dropShadow(color: .gray, opacity: 0.1, offSet: CGSize(width: 0, height: 0))

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        if cell.isSelected == true {
            let location = CLLocation(latitude: self.location[indexPath.row].2, longitude: self.location[indexPath.row].3)
            let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            map.setRegion(viewRegion, animated: true)
            print("33333333")
            map.userTrackingMode = .none
//            self.mapView.setCenter(CLLocationCoordinate2D(latitude: self.location[indexPath.item].2, longitude: self.location[indexPath.item].3), animated: true)
            
        }
    }
}
