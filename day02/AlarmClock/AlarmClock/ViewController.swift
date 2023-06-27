//
//  ViewController.swift
//  AlarmClock
//
//  Created by CSMAC09 on 2023/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    
    var formatterPicker : String?
    var formatterNsDate : String?
    @IBOutlet var lblPickerTime: UILabel!
    @IBOutlet var lblCurrentTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        
        
        formatter.dateFormat="HH:mm"
        lblPickerTime.text = "선택시간: " + formatter.string(from: datePickerView.date)
        formatterPicker = formatter.string(from: datePickerView.date)
        print("cururnet " + formatterPicker!)
        
    }
    @objc func updateTime(){
        //lblCurrentTime.text = String(count)
        //count = count + 1
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat="HH:mm"
        lblCurrentTime.text="현재시간: " + formatter.string(from: date as Date)
        formatterNsDate = formatter.string(from: date as Date)
        print ("select " + formatterNsDate!)
        
        if(formatterPicker == formatterNsDate)
        {
            let timeOnAlert = UIAlertController(title: "알림", message: "설정된 시간입니다.", preferredStyle: UIAlertController.Style.alert)
            //얼럿 대화상자 자체 -> 컨트롤 하는 대화상자를 제어 preferredStyle 대화상자 스타일 -> alert 형태로 띄워라
            let onAction = UIAlertAction(title: "네 알겠습니다", style: UIAlertAction.Style.default, handler: nil)
            //action 부분을 개개체로 만들어서 추가 버튼을 눌렀을 때 핸들러 : 버튼을 눌렀을 때 동작하는 부분이 비어있음 함수를 만들어서 넣어주ㅡㄴ 경우 닫으면 그냥 nil 넣으면 된다
            
            timeOnAlert.addAction(onAction)
            //기능 연결시키기
            
            present(timeOnAlert, animated: true, completion: nil)

        }
//        view.backgroundColor = UIColor.white
    }
    
}


//델리게이트 외부에서 기능 연결할 수 있도록 돕는 친구
//피커 기능을 밖에다 수행해놓고 만들 수 잇다.
//익명함수 사용방식에 대해 
