//
//  ViewController.swift
//  HelloWorld
//
//  Created by CSMAC09 on 2023/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lblHello: UILabel!//화면의 요소와 연결되어있다를 의미 점 두개 & 변수 var 이용 변수이름 : type & ! null과 관련된 연산자 & 어노테이션 -> 화면과 연결 되어있는 변수다(일반적 선언한 변수가 아니다)
    
    @IBOutlet var lblCopyHello: UILabel!
    @IBOutlet var txtName: UITextField!//화면우치ㅣ하는 요소
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSend(_ sender: UIButton) {//버튼은 함수추가 //sender라는 객체가 들어온다 버튼 누르면 텍스트 필드 일거와서 레이블에 바꿔치기 //화면에 동작하는 요소
        lblHello.text="Hello, "+txtName.text!
    }
    //스토리보드 형태로 구현 유아이컨트롤러 상속 받아서 하나의 뷰 컨트롤러를 만듬
    @IBAction func btnSendCopy(_ sender: UIButton) {
        lblCopyHello.text = lblHello.text
    }
    //화면의 요소를 관리하는 클래스
    //버튼 레이블 관리
    //뷰디드로드 -> 뷰를 로딩을 했을 때 화면의 요소가 다 수행됐을 떄 실행되는 메소드 바뀐내용 보여주는 작업 오버라이드(상속 재정의)-> 부모클래스의 메소드를 재정의함
    //func 사용 매개변수 _로 지정
    //:하고 return 값 적을 수 있음
    //Strong Week -> 메모리의 특정 정보가 있을 때 용량 부족하면 Strong은 삭제 안되고 week는 삭제될 수도
    //let도존재 ?,!도 존재

}

