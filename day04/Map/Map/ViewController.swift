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
        locationManager.startUpdatingLocation()//현재위치 받기 시작함 //locationManager 실행 //
        //위치정보를 계속 받아오고, 수신
        myMap.showsUserLocation = true
        //사용자 위치정보를 활성화
    }//-> 실제 위치정보를 받아와서 지도랑 연결해서 특정 위치가 나올 수 있도록 해줘야함
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double)->CLLocationCoordinate2D { //->위치정보 수신 했을 때 호출
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        //현재 위치를 받아온다 클래스 (위치 좌표) 2DMake-> 지도를 2차원 좌표를 표시할 수 있는 클래스
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)// 위도 경도 확대 배율 지정 객체로 만듬
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        // 두개를 사용해서 내가 봐야할 지점을 옮김 (확대)
        //지도에 저장
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }//현재위치를 받는 함수를 만들어야 계쏙 업데이트 된다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        //마지막 위치정보를 전달
        //갱신 받은 최신정보이기도 하다
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) //golocation 전달
        //위치정보 갱신될 때마다 최신의 정보가 보여진다.
        
        
        //주소 정보를 지리적인 정보를 지오코딩
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            //클래스 객체를 만드는 것 객체가 가지고 있는 reverseGeocodeLocation
            //매개변수 pLocation(위치정보가 전달됨), completionHandler:(지오코딩을 수행하는 부분)(함수를 축약한 형태) pLocation->placemarks 위치정보가 들어간다 : 하나의 위도 경도안에 여러개 주소정보가 있음
            // 복수개 형태
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            
            var address:String = country!
            
            
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재위치"
            self.lblLocationInfo2.text = address
        })//위치정보가 업데이트 될때마다 호출한다.
        
        locationManager.stopUpdatingLocation() //더이상 gps 수신안한다.
        //서버에 지오코딩 정보를 물어보느너긱 때문에 네트워크 필요
    }//로케이션 메니저한테 델리게이트 받은 메소드임
    
    //위도 경도를 주소로 바꾸는거 지오코딩
    //반대는 역지오코딩
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double, title strTitle:String, subtitle strSubtitle:String){
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)//핀이 찍히는 형태annotation.coordinate
        //위도경도를 반환해서 어노테이션한테 전달
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
        //map에 집어 넣는 코드
        //배열로 만들어서 추가 하면 여러개 어노테이션 만듬
    }//핀이 필요할 때 마다 호출한다.
    // MKPointAnnotation() 형태 객체 생성
    
    
    
    //위치정보 핑
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation() // 다시 위치 받을 수 있도록
        }
        else if sender.selectedSegmentIndex == 1{
            setAnnotation(latitudeValue: 37.606264099001244, longitudeValue: 127.04208098139232 , delta: 0.05, title:"ddwu", subtitle: "학교><")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "학교"
        }
        else if sender.selectedSegmentIndex == 2{
            setAnnotation(latitudeValue: 37.638343965434316, longitudeValue: 127.02564805663476 , delta: 0.05, title:"우리집", subtitle: "수유역")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "우리집"
        }
        else if sender.selectedSegmentIndex == 3{
            setAnnotation(latitudeValue: 37.601471131002455, longitudeValue: 127.04123178993306 , delta: 0.05, title:"월곡역", subtitle: "월곡역")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "월곡역"
        }
        
    }
    
}

