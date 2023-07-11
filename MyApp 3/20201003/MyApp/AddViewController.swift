//
//  ViewController.swift
//  MyApp
//
//  Created by cs_mac on 2020/07/22.
//  Copyright © 2020 cs_mac. All rights reserved.
//

import UIKit

var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]

class AddViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{

    
    @IBOutlet var dpPicker: UIDatePicker!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDetail: UITextField!
    var choicImage : String = "cart.png"
    @IBOutlet var pickerImage: UIPickerView!
    let manager = DBManager()
    var imageArray = [UIImage?]()
    @IBOutlet var imageView: UIImageView!
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // DatePicker 에 현재 시간 설정
        let date = NSDate()
        dpPicker.setDate(date as Date, animated: true)
        
        for i in 0 ..< 3 {
            let image = UIImage(named:  itemsImageFile[i])
            imageArray.append(image)
        }
        // Do any additional setup after loading the view.
        
        imageView.image=imageArray[0]
    
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemsImageFile.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            imageView.image=imageArray[row]
            choicImage = itemsImageFile[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {//return 값 표시는 화살표
        //액자 틀 줄이는
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame=CGRect(x:0, y:0, width: 70, height: 70)
        
        return imageView
    }//피커에서 이미지를 보여주는
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    @IBAction func btnSave(_ sender: UIButton) {
        // 뷰에 입력한 값을 사용하여 DB에 추가
        let date = Int32(dpPicker.date.timeIntervalSince1970)
        manager.insertData(title: tfTitle.text ?? " ", date: date, detail: tfDetail.text ?? " ", icon: choicImage)
        
        _ = navigationController?.popViewController(animated: true)
    }
    

}

