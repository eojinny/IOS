//
//  ViewController.swift
//  Navigation
//
//  Created by CSMAC09 on 2023/06/29.
//

import UIKit

class ViewController: UIViewController , EditDelegate{

    @IBOutlet var txtMessage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// 세그워ㅔ이 타고 가기전 직전에 호출되고 매개변수로 들어온다, 누가 보내는지 센더도 이씀 타고가는 흐름에는 어떤 세그웨이인지 정보랑 대상이 되는 항목을 알 수 있다
        //보내는(메인) 녀석이 누구냐, 세그위에가 뭐냐
        //segue.destination as! EditViewController 세그웨이 타고 가서 나오는 -> as 타입캐스팅
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "editButton"{
            editViewController.textWayValue = "segue : use button"
            //editViewController에서 textWayValu 멤버면수를 추가했고 호출하고 있다 세그웨이에 아이덴디파이어로 구분하고 있는 것
        }else if segue .identifier == "editBarButton"{ // 어떤 세그웨이에 아이덴디파이어로 구분하고 있는 것 아이덴티파이는 필수적 선언
            editViewController.textWayValue = " segue : use Bar Button"
        }
        
        editViewController.textMessage = txtMessage.text!
        editViewController.delegate = self
    }

    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message
    }
}

