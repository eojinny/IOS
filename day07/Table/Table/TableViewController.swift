//
//  TableViewController.swift
//  Table
//
//  Created by CSMAC09 on 2023/06/30.
//

import UIKit


var items = ["책구매", "철수와 약속", "스터디 준비하기"]
var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]

//db 데이터 등 데이턴 리스트 형태가 필요
//클래스 소속되어잇지 않고 클래스에서 바깥쪽 전역쪽으로 사용 다른 컨트롤러에서 도 사용 가능

class TableViewController: UITableViewController {
    
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }//뷰가 만들어지는 시점에만 한번 호출

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }// 한줄에 몇개의 칸이 있는지
    // 아이콘 하나만 그래서 한칸

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }//데이터 갯수만큼 몇줄인지 알려줘야함
    
    //cell에 직접 반영하기 위해 필ㄹ요한 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //ReusableCell -> 데이터만 변경해주기 -> 큐에서 꺼내서 항목의 이름을 mycell로 지정 -> indexPath 몇번 째인지 담고 있음
        
        // Configure the cell...
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]//indexPath as NSIndexPath 한칸에 대한 정보를 타입캐승팅해서 그중 몇번째 정보인지 row만 꺼내서 원본데이터와 배열의순서가 일치하면 꺼내진다.
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        
        return cell //만들어진 셀 반환
    }//indexPath 원본데이터가 몇개이니? 10개이면 10개에 해당하는 셀을 반환 mycell의 여러개 줄이 완성됨
    //원본데이터 집어 넣고 데이터 결합이 필요
    //세그웨이랑 연결해서 셀 하나 누르면 add로 넘어감
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    //삭제에 해당하는 메소드
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
           
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at:  (indexPath as NSIndexPath).row)
            //화면상이 아니라 데이터까지 삭제할 수 있도록 만들기
            
       
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) { //from을 to로 옮길거다
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row] //원본데이터 기록 해놨다가
        
        items.remove(at: (fromIndexPath as NSIndexPath).row) // 원본 데이터를 삭제하고
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        
        items.insert(itemToMove, at: (to as NSIndexPath).row)// 목표한 위치에다가 기록한 원본데이터를 넣어준다.
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[(indexPath! as NSIndexPath).row])
        }
    }

    override func viewWillAppear(_ animated: Bool) {tvListView.reloadData()}//데이터가 변동될 때는 뷰가 사라질 때마다 나타남 최신정보 바꿀 때 변경
    /*
    override func viewDidAppear(_ animated: Bool) {
        <#code#>
    }//이미 완성이 되었을 때 그후에 완전에 뷰가 보이고 나서 작업할 때 
    */
}
