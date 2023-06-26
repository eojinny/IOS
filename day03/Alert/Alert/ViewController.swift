//
//  ViewController.swift
//  Alert
//
//  Created by CSMAC09 on 2023/06/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lampImg: UIImageView!
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    
    var isLampOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lampImg.image=imgOn
    }
    @IBAction func btnLampOn(_ sender: UIButton) {
        if(isLampOn == true)
        {
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 ON 상태입니다.", preferredStyle: UIAlertController.Style.alert)
            //얼럿 대화상자 자체 -> 컨트롤 하는 대화상자를 제어 preferredStyle 대화상자 스타일 -> alert 형태로 띄워라
            let onAction = UIAlertAction(title: "알겠습니다", style: UIAlertAction.Style.default, handler: nil)
            //action 부분을 개개체로 만들어서 추가 버튼을 눌렀을 때 핸들러 : 버튼을 눌렀을 때 동작하는 부분이 비어있음 함수를 만들어서 넣어주ㅡㄴ 경우 닫으면 그냥 nil 넣으면 된다
            
            lampOnAlert.addAction(onAction)
            //기능 연결시키기
            
            present(lampOnAlert, animated: true, completion: nil)
            //지금 만든 컨트롤러 만들고 애니매이션 효과 줄 것인지 기능 수행 후 뭘할건지
            //컨트롤러, 액션 ,프레젠트
        }else
        {
            lampImg.image=imgOn
            isLampOn=true
        }
    }
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn {
            let lampOffAlert = UIAlertController(title: "램프끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let offAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {
                ACTION in self.lampImg.image = self.imgOff
                self.isLampOn=false
            })//in self.lampImg.image 이미지 오프 이미지를 넣어주고 램프를 false로 변경하라는 기능
            //핸들러 안에 함수 넣음
            //익명함수
            //매개변수 - Action 타입은 알 수 없지만 시스템은 알고 있음
            //self 키워드 뷰 컨트롤러 안에서 지정해서
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            
            present(lampOffAlert,animated: true, completion: nil)
        }
        
    }
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프제거", message: "램프를 제거하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let offAction = UIAlertAction(title: "아니오 끕니다(off)", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImg.image = self.imgOff
            self.isLampOn=false
        })
        
        let onAction = UIAlertAction(title: "아니오 켭니다(on)", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImg.image = self.imgOn
            self.isLampOn=true
        })
        let removeAction = UIAlertAction(title: "네 제거합니다.", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImg.image = self.imgRemove
            self.isLampOn=false
        })
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        present(lampRemoveAlert,animated: true, completion: nil)
    }
    

}

