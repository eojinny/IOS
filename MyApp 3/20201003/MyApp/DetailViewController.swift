//
//  DetailViewController.swift
//  MyApp
//
//  Created by cs_mac on 2020/07/22.
//  Copyright © 2020 cs_mac. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class DetailViewController: UIViewController, CLLocationManagerDelegate {
    
    var receiveTask: TaskDto!

    @IBOutlet var lblDate: UILabel!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDetail: UITextField!
    
    @IBOutlet var myMap: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 전달 받은 TaskDto 의 시간 정수 값을 시간 형식으로 변경하여 표시
        let date = Date(timeIntervalSince1970: TimeInterval(receiveTask.date))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE hh:mm a"
        lblDate.text = formatter.string(from: date)
        
        tfTitle.text = receiveTask.title
        tfDetail.text = receiveTask.detail
        
        
    }
    
    func receiveItem(_ task: TaskDto) {
        // TaskDto 가 잘 전달되었는지 확인
        print("received: \(task.id)")
        receiveTask = task
        CLGeocoder().geocodeAddressString(receiveTask.detail!, completionHandler:{
            (placemark, error) -> Void in
            let location = placemark?.first?.location
            //print(location?.coordinate.latitude)
            //print(location?.coordinate.longitude)
            self.goLocation(latitudeValue: location?.coordinate.latitude ?? 0.0, longitudeValue: location?.coordinate.longitude ?? 0.0, delta: 0.01)
        })
        
    }

    // 화면의 입력 값(제목, 내용) 으로 DB 수정
    @IBAction func btnModify(_ sender: UIButton) {
        manager.updateData(id: Int32(receiveTask.id), title: tfTitle.text!, detail: tfDetail.text!)
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double)->CLLocationCoordinate2D { //->위치정보 수신 했을 때 호출
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        //현재 위치를 받아온다 클래스 (위치 좌표) 2DMake-> 지도를 2차원 좌표를 표시할 수 있는 클래스
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)// 위도 경도 확대 배율 지정 객체로 만듬
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        // 두개를 사용해서 내가 봐야할 지점을 옮김 (확대)
        //지도에 저장
        myMap.setRegion(pRegion, animated: true)
        return pLocation
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
