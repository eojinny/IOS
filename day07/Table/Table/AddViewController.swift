//
//  AddViewController.swift
//  Table
//
//  Created by CSMAC09 on 2023/06/30.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

  
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var tfAddVeiw: UITextField!
    var choicImage : String!
    var imageArray = [UIImage?]()
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< 3 {
            let image = UIImage(named:  itemsImageFile[i])
            imageArray.append(image)
        }
        // Do any additional setup after loading the view.
        
        imageView.image=imageArray[0]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }//피커뷰에 몇개 보여줄 건지 알려주는 메소드 피커뷰의 개수 두개로 보여줄 수 있음 듀개선택, 몇칸으로 항목을 선택할 수 있는지
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemsImageFile.count
    }// 배열의 갯수, 몇개의 항목을 보여줄건지
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        //원본데이터에 추가 후 갱싱하는 작업이 필요
        items.append(tfAddVeiw.text!)
        itemsImageFile.append(choicImage!)
        tfAddVeiw.text=""
        _=navigationController?.popViewController(animated: true)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            imageView.image=imageArray[row]
            choicImage = itemsImageFile[row]
    
    
    }//스크롤 했을 때 이벤트가 동작했을 때
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {//return 값 표시는 화살표
        //액자 틀 줄이는
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame=CGRect(x:0, y:0, width: 100, height: 150)
        
        return imageView
    }//피커에서 이미지를 보여주는
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    
}//원본 데이터 수정 후 -> 반영하도록 갱신 순서가 중요
