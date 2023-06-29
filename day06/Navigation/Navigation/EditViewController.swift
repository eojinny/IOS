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
}

class EditViewController: UIViewController {
    var textWayValue: String = ""

    @IBOutlet var txMessage: UITextField!
    @IBOutlet var lblWay: UILabel!
    
    var textMessage: String = ""
    var delegate : EditDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil{
            delegate?.didMessageEditDone(self, message: txMessage.text!)
        }
        _ = navigationController?.popViewController(animated: true)
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
