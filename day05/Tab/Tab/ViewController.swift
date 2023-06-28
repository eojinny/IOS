//
//  ViewController.swift
//  ImageViewTest
//
//  Created by CSMAC09 on 2023/06/22.
//

import UIKit

class ViewController: UIViewController {
    

   // @IBOutlet var imgView: UIImageView!
    var img: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //img = UIImage(named: "File.png")
        //imgView.image=img
    }
    @IBAction func btnMoveImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func btnMoveDatePickerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
    
}

