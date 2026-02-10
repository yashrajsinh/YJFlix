//
//  ViewController.swift
//  YJFlix
//
//  Created by Yashraj on 09/02/26.
//

import FirebaseAuth
import FirebaseCore
import UIKit

class ViewController: UIViewController {

    //UI: Textfields
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    //Spinner
    var spinner: UIActivityIndicatorView!
    var overlayView: UIView!

    //for auto log in user
    var authListener: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Spinner
        setupSpinner()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        authListener = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.gotoMainScreen()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let listener = authListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }

    @IBAction func btnLogIn(_ sender: UIButton) {
        let email = txtEmail.text! ?? ""
        let password = txtPassword.text! ?? ""

        if email.isEmpty || password.isEmpty {
            toast("Please fill all the fields")
            return
        }
        showSpinner()
        view.isUserInteractionEnabled = false  //bloacks user taps
        //Fireabse method for validation
        Auth.auth().signIn(withEmail: email, password: password) {
            result,
            error in
            if let error = error {
                self.hideSpinner()
                self.toast("Log in failed " + error.localizedDescription)
                return
            }
            self.gotoMainScreen()
        }

    }

    //MARK: Func Spinner with animation
    func setupSpinner() {
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.isHidden = true

        spinner = UIActivityIndicatorView(style: .large)
        spinner.center = overlayView.center
        spinner.color = .white

        overlayView.addSubview(spinner)
        view.addSubview(overlayView)
    }

    func showSpinner() {
        overlayView.isHidden = false
        spinner.isUserInteractionEnabled = false
        spinner.startAnimating()
    }

    func hideSpinner() {
        spinner.stopAnimating()
        spinner.isUserInteractionEnabled = true
        overlayView.isHidden = true
    }

    //MARK: Custom Toast message
    func toast(_ msg: String) {
        let lbl = UILabel(
            frame: CGRect(
                x: 40,
                y: view.frame.height - 120,
                width: view.frame.width - 80,
                height: 40
            )
        )
        lbl.text = msg
        lbl.textAlignment = .center
        lbl.backgroundColor = .black.withAlphaComponent(0.7)
        lbl.textColor = .white
        lbl.layer.cornerRadius = 10
        lbl.clipsToBounds = true
        lbl.alpha = 0
        view.addSubview(lbl)

        UIView.animate(withDuration: 0.3) { lbl.alpha = 1 }
        UIView.animate(withDuration: 0.3, delay: 2) {
            lbl.alpha = 0
        } completion: { _ in
            lbl.removeFromSuperview()
        }
    }

    //MARK: Func to add tabbar on home VC
    func gotoMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let homeVC =
            storyboard.instantiateViewController(
                withIdentifier: "HomeVC"
            ) as! HomeViewController

        let moviesVC =
            storyboard.instantiateViewController(
                withIdentifier: "MoviesVC"
            ) as! MoviesViewController

        let profileVC =
            storyboard.instantiateViewController(
                withIdentifier: "ProfileVC"
            ) as! ProfileViewController

        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )

        let moviesNav = UINavigationController(rootViewController: moviesVC)
        moviesNav.tabBarItem = UITabBarItem(
            title: "Movies",
            image: UIImage(systemName: "film.fill"),
            tag: 1
        )

        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            tag: 2
        )

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, moviesNav, profileNav]

        // Replace root controller
        if let windowScene = UIApplication.shared.connectedScenes.first
            as? UIWindowScene,
            let window = windowScene.windows.first
        {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}
