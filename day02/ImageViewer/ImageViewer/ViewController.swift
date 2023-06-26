//
//  ViewController.swift
//  ImageViewer
//
//  Created by CSMAC09 on 2023/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    var imageName : UIImage?
    var imageNo : Int = 1
    @IBOutlet var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageName = UIImage(named:String(imageNo) + ".png")
        imgView.image=imageName
    }

    @IBAction func btnBefore(_ sender: UIButton) {
        
        imageNo=imageNo-1
        imgView.image = UIImage(named:String(imageNo) + ".png")
            
        
    }
    @IBAction func btnAfter(_ sender: UIButton) {
        
        imageNo=imageNo+1
        imgView.image = UIImage(named:String(imageNo) + ".png")
        
    }
    
}

