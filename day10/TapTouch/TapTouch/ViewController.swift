//
//  ViewController.swift
//  TapTouch
//
//  Created by CSMAC09 on 2023/07/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtTapCount: UILabel!
    
    @IBOutlet var txtTouchCount: UILabel!
    
    @IBOutlet var txtMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String (touches.count)
    
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String (touches.count)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
    }

}

