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

    @IBAction func btnGotoUrl(_ sender: UIButton) {
    }
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://eclass.dongduk.ac.kr/ilos/main/main_form.acl")
    }
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://naver.com")
    }
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
    }
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
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

