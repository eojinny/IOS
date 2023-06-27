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
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double){
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        //현재 위치를 받아온다 클래스 (위치 좌표) 2DMake-> 지도를 2차원 좌표를 표시할 수 있는 클래스
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)// 위도 경도 확대 배율 지정 객체로 만듬
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        // 두개를 사용해서 내가 봐야할 지점을 옮김 (확대)
        //지도에 저장
        myMap.setRegion(pRegion, animated: true)
        
    }//현재위치를 받는 함수를 만들어야 계쏙 업데이트 된다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        //마지막 위치정보를 전달
        //갱신 받은 최신정보이기도 하다
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) //golocation 전달
        //위치정보 갱신될 때마다 최신의 정보가 보여진다.
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
        })//위치정보가 업데이트 될때마다 호출한다.
    }//로케이션 메니저한테 델리게이트 받은 메소드임
    
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
    
}

