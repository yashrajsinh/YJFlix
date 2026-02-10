//
//  ProfileViewController.swift
//  YJFlix
//
//  Created by Yashraj on 09/02/26.
//

import FirebaseAuth
import UIKit

class ProfileViewController: UIViewController {
    //Spinner
    var spinner: UIActivityIndicatorView!
    var overlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogOut(_ sender: Any) {
        logOutUser()
    }

    func logOutUser() {

        do {
            try Auth.auth().signOut()

        } catch {
            print("Error signing out: \(error.localizedDescription)")
            return
        }

        //Load Login screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginVC"
        )

        //Make Login screen the MAIN screen
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }

}
