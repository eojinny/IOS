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
            view.backgroundColor = UIColor.red
        }
//        view.backgroundColor = UIColor.white
    }
    
}

