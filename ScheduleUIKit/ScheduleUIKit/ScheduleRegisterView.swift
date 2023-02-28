//
//  ScheduleRegister.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/26.
//

import UIKit
import Firebase

class ScheduleRegisterView: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var memoText: UITextField!
    
    @IBAction func scheduleRegisterButton(_ sender: UIButton) {
        save(title: titleText.text ?? "", date: datePicker.date, memo: memoText.text ?? "")
        print("2")
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var scheduleArray: [ScheduleInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func save(title: String, date: Date, memo: String) {
        print("1")
        do {
            let user = ScheduleInfo(date: date, title: title, memo: memo)
//            print(user)
            try Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "err").collection("schedule").document().setData(from: user)
        } catch {
            print(error)
        }
    }

}
