//
//  ScheduleViewController.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/23.
//

import UIKit
import Firebase

class ScheduleListScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var scheduleArray = [ScheduleInfo]()
    var num: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        Task{
            await getSInfo()
        }
        tableView.rowHeight = 120
//        print("bbbb2")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
     
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        Task {
//            await getSInfo()
//        }
//        print("aaaaaaa2")
//    }
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return scheduleArray.count  // 表示するデータが入っている配列を想定
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return scheduleArray.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schedule = scheduleArray[indexPath.row+num]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
        cell.setSchedule(scheduleInfo: schedule)
//        num += 1
//        print(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    @objc func reloadTableView(notification: NSNotification) {
        Task{
            await getSInfo()
        }
    }
    
    func getSInfo() async {
        do {
            let db = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "err").collection("schedule")//.whereField("date", isGreaterThan: Date())
            let infos = try await db.getDocuments()
            self.scheduleArray = infos.documents.compactMap({ item in
                return try? item.data(as: ScheduleInfo.self)
            })
            self.tableView.reloadData()
//            print(self.scheduleArray)
        } catch {
            print(error.localizedDescription)
        }
    }
}

//extension ScheduleListScreen: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return scheduleArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let schedule = scheduleArray[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
//        cell.setSchedule(scheduleInfo: schedule)
//        print(cell)
//        return cell
//    }
    
    
//}
