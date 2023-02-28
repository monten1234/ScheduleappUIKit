//
//  ViewController.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/28.
//

import UIKit
import FirebaseAuth

class LogoutViewController: UIViewController {

    @IBAction func logoutButton(_ sender: UIButton) {
        logout()
    }
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
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set(false, forKey: "isLogin")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let next = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
