//
//  ViewController.swift
//  Map
//
//  Created by CSMAC09 on 2023/06/27.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    //지도만 셀프로 델리게이트 하겠다고 지정하기

    @IBOutlet var myMap: MKMapView!
    
    @IBOutlet var lblLocationInfo1: UILabel!
    
    @IBOutlet var lblLocationInfo2: UILabel!
    
    //gps 시스템에서 하는거가ㅣ 때문에 제공받아야함
    let locationManager = CLLocationManager()
    //위치 관리자 시스템 클래스 위치정보를 받아올 때 델리게이트해서 준비 할 수 잇ehfhr
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate=self // 전체말고 일부 지도만 델리게이트하겠다 지정
        //일부 기능을 델리게이트 셀프한다
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //정확도 => 위성 > 네트워크(공유기 반경, 설치된 위치에 따라)
        //gps 미국 체계
        //가장 정확한 위치정보를 사용하겠다. 실내에 있을 땐 넽웤, 실외 gps
        locationManager.requestWhenInUseAuthorization()
        //권한요청, 위치정보를 위성으로부터 개인정보를 수락
        locationManager.startUpdatingLocation()
        //위치정보를 계속 받아오고, 수신
        myMap.showsUserLocation = true
        //사용자 위치정보를 활성화
    }//-> 실제 위치정보를 받아와서 지도랑 연결해서 특정 위치가 나올 수 있도록 해줘야함

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
    
}

