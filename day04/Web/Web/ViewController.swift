//
//  ViewController.swift
//  Web
//
//  Created by CSMAC09 on 2023/06/27.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var myWebView: WKWebView!
    
    @IBOutlet var txtUrl: UITextField!
    
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url:String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate=self //뷰 컨트롤러를 마이 웹뷰에 연결시켜준다
        //웹뷰가 동작할 때 일부를 navigationDelegate 뷰 컨트롤러에서 구현해서 제어한다는 의미 self = 뷰 컨트롤러 의미
        
        loadWebPage("http://google.com")
    }
    func checkUrl(_ url: String) -> String{
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag{
            strUrl = "http://" + strUrl
        }
        return strUrl
    }

    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://eclass.dongduk.ac.kr/ilos/main/main_form.acl")
    }
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://naver.com")
        //프로토콜 생략하면 동작을 안할 수도 있음 앞부분에 http 기능을 추가하는게 필요함
    }
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String</h1><p> String 변수를 이용한 웹페이지</p> <p><a href=\"http://naver.com\">네이버</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filepath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filepath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
    //델리게이터를 이용해서 인디케이터 구현하기
    //일부만 담당할 때 수동 방법이 어제랑 다름 어제는 전체의 기능임
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden=false
    }
    //웹뷰가 로딩하는 타이밍에 자동으로 호출
    //애니멩션이 동작한 후 보여주는 것
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden=true
    }
    //스탑이 구현 히든 사라는 것
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden=true
    }
    //오류가 났을 때
    
    //웹뷰가 해야하는 걸 뷰 컨트롤러가 대신할 수 있도록 델리게이트가 연결
}

//함수 만드는 규칙
// func 함수명 ( 파마리터 : 자료형) -> 반환값 타입{실행코드}
// 밑줄이 되어있는 경우
// 라벨을 붙여서 매개변수의 이름 U라고 적으면 라벨 사용하면 됨
//익명함수 : 매변, In 반환값 날릴 수 있고 괄호 생략 가능
//_ 매변 생략도 가능
