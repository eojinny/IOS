//
//  ViewController.swift
//  Pinch
//
//  Created by CSMAC09 on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtPinch: UILabel!
    var initialFontSize:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
        //UIGestureRecognizer가 상위클래스를 상속 받은 애
    }
        
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer){
        if (pinch.state == UIGestureRecognizer.State.began){
                initialFontSize = txtPinch.font.pointSize
            //시작 타이밍의 폰트 사이즈를 기준으로 확대해야하기 떄문에 기억을 해야함
            //시작하는 시점이라면 초기 사이즈를 레이블이ㅡ 사이즈로 만든다.
        }else {
                txtPinch.font = txtPinch.font.withSize(initialFontSize + pinch.scale)
        }
    }

}

