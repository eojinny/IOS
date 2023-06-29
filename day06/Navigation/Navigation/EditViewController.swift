//
//  EditViewController.swift
//  Navigation
//
//  Created by CSMAC09 on 2023/06/29.
//

import UIKit

protocol EditDelegate
{
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    @IBOutlet var swisOn: UISwitch!
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var lblWay: UILabel!
    
    var textMessage: String = ""
    var delegate : EditDelegate?
    
    @IBOutlet var btnResize: UIButton!
    
    
    var isOn = false
    var isZoom = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swisOn.isOn = isOn
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil{
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }//self로 바로 넣을 수 있을라면 _ ㅅ사용
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func swImageOnOff(_ sender: UISwitch) {
    
        if sender.isOn {
            isOn = true
        }
        else{
            isOn = false
            
        }
    }
    @IBAction func btnImageZoom(_ sender: UIButton) {
        
        if isZoom {
            btnResize.setTitle("축소", for: .normal)
        }
        else {
            btnResize.setTitle("확대", for: .normal)
        }
        
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
// 세그웨이를 통해 전달 받음
//  반대의 경우 세그웨이를 타고 가는 것이 아니라 델리게이트를 사용한다.
