//
//  ViewController.swift
//  PickerViewTest
//
//  Created by CSMAC09 on 2023/06/25.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 1 //피커 뷰를 상수값으로 지정하면 한개 여러개도 가능
    var imageFileName : [String] = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg",]
    var imageArray = [UIImage?]()
    

    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickerImage: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0 ..< MAX_ARRAY_NUM{
            let image = UIImage(named:  imageFileName[i])
            imageArray.append(image)
        }
        lblImageFileName.text=imageFileName[0]
        imageView.image=imageArray[0]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }//피커뷰에 몇개 보여줄 건지 알려주는 메소드 피커뷰의 개수 두개로 보여줄 수 있음 듀개선택, 몇칸으로 항목을 선택할 수 있는지
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }// 배열의 갯수, 몇개의 항목을 보여줄건지
    
    //실제 항목의 파일이름
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row]
    }//보여주고 싶은거 항목으로 표시 row 순서 알 수있도록
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageFileName.text=imageFileName[row]
        
        imageView.image=imageArray[row]
    }//스크롤 했을 때 이벤트가 동작했을 때
    

}

