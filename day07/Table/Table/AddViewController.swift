//
//  AddViewController.swift
//  Table
//
//  Created by CSMAC09 on 2023/06/30.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var tfAddVeiw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnAddItem(_ sender: UIButton) {
        //원본데이터에 추가 후 갱싱하는 작업이 필요
        items.append(tfAddVeiw.text!)
        itemsImageFile.append("clock.png")
        tfAddVeiw.text=""
        _=navigationController?.popViewController(animated: true)
        
    }
}//원본 데이터 수정 후 -> 반영하도록 갱신 순서가 중요
