//
//  DetailViewController.swift
//  Table
//
//  Created by CSMAC09 on 2023/06/30.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveItem = ""
    @IBOutlet var lblItem: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func receiveItem(_ item : String){receiveItem = item}

}
