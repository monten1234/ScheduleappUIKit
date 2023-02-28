//
//  FriendView.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/28.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
//    var membersArray: [UserData] = []
    var friendsArray: [UserData] = []
    var friendsNames = [UserData]()
//    var num = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        // Do any additional setup after loading the view.
        Task{
            await getmembers()
            await getUsernames()
            tableView.reloadData()
            
            print(self.friendsArray)
            print(self.friendsArray.count)
            //            self.tableView.reloadData()
            print(self.friendsNames)
            print(self.friendsNames.count)
//            print(111111)
        }
//        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("\(friendsArray.count)")
//        print(1)
        
        return self.friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendViewCell") as! FriendViewCell
        let friendName = friendsArray[indexPath.row]
        cell.setUserName(userName: friendName.id ?? "")
//        num += 1
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 8
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let marginView = UIView()
//        marginView.backgroundColor = .clear
//        return marginView
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return .leastNonzeroMagnitude
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getmembers() async {
        do {
            let db = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "err").collection("friend").whereField("isCheck", isEqualTo: true)
            let infos = try await db.getDocuments()
            self.friendsArray = infos.documents.compactMap({ item in
                return try? item.data(as: UserData.self)
            })
            
//            print("a")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUsernames() async {
        Task{
            for i in 0..<self.friendsArray.count {
                //            print(self.num)
                await getUsername(item: self.friendsArray[i].id ?? "err")
                //            print(self.friendsNames)
            }
            self.tableView.reloadData()
        }
    }
    
    func getUsername(item: String) async {
        let db = Firestore.firestore().collection("users")
        let document = db.document(item)
//                let membersname = try await document.getDocuments()
//                self.sentGroupDatas = membersname.documents.compactMap({ item in
//                    return try? item.data(as: UserSample.self)
//                })
        document.getDocument { (documentSnapshot, error) in
            if error != nil  {
                // エラーが発生した場合
                print("error")
//                print(self.num)
            } else if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                // ドキュメントが取得できた場合
                let data = documentSnapshot.data()
//                print(data as Any)
//                print(self.num)
                // フィールド情報を取得する
                let name = data!["name"]
                
                let userdata = UserData(id:item, name:name as? String)
//                print(userdata)
//                print(self.num)
//                self.num += 1
                self.friendsNames.append(userdata)
                print("\(self.friendsNames)!!!!!")
                print("\(self.friendsNames.count)")
            } else {
                // ドキュメントが存在しない場合
                print("Document does not exist")
            }
        }
//        self.tableView.reloadData()
    }
}
