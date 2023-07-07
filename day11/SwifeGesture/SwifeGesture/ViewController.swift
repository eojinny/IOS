//
//  ViewController.swift
//  PinchGesture
//
//  Created by CSMAC09 on 2023/07/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgViewRight: UIImageView!
    @IBOutlet var imgViewLeft: UIImageView!
    @IBOutlet var imgViewDown: UIImageView!
    @IBOutlet var imgViewUp: UIImageView!
    
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    var imgUp = [UIImage]()
    var imgDown = [UIImage]()
    
    let numOfTouchs = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgUp.append(UIImage(named: "arrow-up-black.png")!)
        imgUp.append(UIImage(named: "arrow-up-red.png")!)
        imgDown.append(UIImage(named: "arrow-down-black.png")!)
        imgDown.append(UIImage(named: "arrow-down-red.png")!)
        imgLeft.append(UIImage(named: "arrow-left-black.png")!)
        imgLeft.append(UIImage(named: "arrow-left-red.png")!)
        imgRight.append(UIImage(named: "arrow-right-black.png")!)
        imgRight.append(UIImage(named: "arrow-right-red.png")!)
        
        imgViewUp.image = imgUp[0]
        imgViewDown.image = imgDown[0]
        imgViewLeft.image = imgLeft[0]
        imgViewRight.image = imgRight[0]
        
            //4개의 recgnizer  respons 함수는 구현할 것
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipeUp.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeUp)
        
        //UISwipeGestureRecognizer 셀프 뷰 컨트롤러, 액션에 설렉터를 넣어준다
        //함수 이름을 전달
        //respondToSwipeGesture(_:) 라벨 매개변수 이름 매개변수 타입
        //라벨 있고 이름 생략 타입 생략 매개변수 하나 , 매개변수 타입 적을 필요 없음 미리 약속 도ㅣ어잇어서
        //스와이프의 디렉션을 지정해준다
        // 뷰 컨트롤ㄹ러 뷰에 에드를 해준다.
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipeDown.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        swipeLeft.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        swipeRight.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRight)
    }
    //
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as?  UISwipeGestureRecognizer{//제스처 중 스와이프다 하위 클래스 상위 클래스
            imgViewUp.image = imgUp[0]
            imgViewDown.image = imgDown[0]
            imgViewLeft.image = imgLeft[0]
            imgViewRight.image = imgRight[0]
            //다시 검정으로 돌아와야하기 때문에 초기화를 위해
            
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.up:
                imgViewUp.image = imgUp[1]
            case UISwipeGestureRecognizer.Direction.down:
                imgViewDown.image = imgDown[1]
            case UISwipeGestureRecognizer.Direction.left:
                imgViewLeft.image = imgLeft[1]
            case UISwipeGestureRecognizer.Direction.right:
                imgViewRight.image = imgRight[1]
            default:
                break
                
            }
            
        }// 터치와의 차이 UISwipeGestureRecognize 클래스 사용해서 하는 것과 오버라이드(터치)와 하는 것과
        // 기본 클래스에 포함된 기본 터치 기존 클래스에 확장된 기능을 끼어 넣ㅇ르 ㅅ ㅜ 있도로 UISwipeGestureRecognize
        // 만들어서 끼워넣음 클래스에서 상속 받아서 구현 하고 구현한 클래스를 사용하는게 좋음
    }

}

