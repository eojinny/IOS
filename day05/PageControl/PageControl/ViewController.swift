//
//  ViewController.swift
//  PageControl
//
//  Created by CSMAC09 on 2023/06/28.
//

import UIKit

var images = ["01.png","02.png","03.png","04.png","05.png","06.png"]
//모든 범위에서 사용할 수 있도록 전역 변수 선언
class ViewController: UIViewController {
    

    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var lblTxt: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named:  images[0])
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
        lblTxt.text = "page:" + String(pageControl.currentPage)
    }
    
}

