//
//  ViewController.swift
//  DataBaseTest
//
//  Created by CSMAC09 on 2023/07/10.
//

import UIKit
import SQLite3
//반복적 코드 -> 보일러코드
//클래스 디비 관리해서
class ViewController: UIViewController {

    var manager : DBManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = DBManager()
        
    }
    @IBAction func btnOpenDatabase(_ sender: UIButton) {
        manager.initDatabase()
    }
    @IBAction func btnCreateTable(_ sender: UIButton) {
      
    }
    @IBAction func btnInsert(_ sender: UIButton) {
        manager.insert()
    }
    @IBAction func btnSelectAll(_ sender: UIButton) {
        manager.selectAll()
    }
    @IBAction func btnUpdate(_ sender: UIButton) {
        manager.update()
      
    }
    @IBAction func btnDelete(_ sender: UIButton) {
        manager.delete()
    }
    @IBAction func btnCloseDatabase(_ sender: UIButton) {
        manager.closeDatebase()
    }
    
   
    
}

//day07 확장
