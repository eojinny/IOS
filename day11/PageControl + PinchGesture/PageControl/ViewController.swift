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
    var cnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
       
        lblTxt.text = "page:" + String(pageControl.currentPage)
        
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named:  images[0])
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
       // swipeUp.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        //swipeDown.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        //swipeLeft.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        //swipeRight.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRight)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
        
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as?  UISwipeGestureRecognizer{//제스처 중 스와이프다 하위 클래스 상위 클래스
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.up:
                imgView.image = UIImage(named:  images[0])
                lblTxt.text = "page:" + String(0)
            case UISwipeGestureRecognizer.Direction.down:
                imgView.image = UIImage(named:  images[5])
                lblTxt.text = "page:" + String(5)
            case UISwipeGestureRecognizer.Direction.left:
                pageControl.currentPage += 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
                lblTxt.text = "page:" + String(pageControl.currentPage)
            case UISwipeGestureRecognizer.Direction.right:
                pageControl.currentPage -= 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
                lblTxt.text = "page:" + String(pageControl.currentPage)
            default:
                break
            }
        }
    }
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer){
        imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
}

