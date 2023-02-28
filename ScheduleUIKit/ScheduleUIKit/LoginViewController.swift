//
//  LoginViewController.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/27.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    

    @IBOutlet weak var mailAdressText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBAction func loginButton(_ sender: UIButton) {
        login()
    }
    
//    var isLoggedIn = UserDefaults.standard.bool(forKey: "isLogin")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func login() {
        Auth.auth().signIn(withEmail: mailAdressText.text ?? "", password: passWordText.text ?? "") { authResult, error in
            if authResult?.user != nil {
                print("success")
                UserDefaults.standard.set(true, forKey: "isLogin")
//                self.isPresentedLoginView = false
//                NavigationLink(destination: HomeView(),isActive: $shouldShowSecondView) {
//                    EmptyView()
//                }
//                //Storyboardを指定
//                let anotherStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//                //生成するViewControllerを指定
//                let anotherViewController:TabViewController = anotherStoryboard.instantiateInitialViewController() as! TabViewController
//
//                //表示
                //                self.present(anotherViewController, animated: true, completion: nil)
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let next = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! UITabBarController
                next.modalPresentationStyle = .fullScreen
                self.present(next, animated: true, completion: nil)
            } else {
                print(error!)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
