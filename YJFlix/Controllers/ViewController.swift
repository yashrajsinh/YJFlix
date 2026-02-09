//
//  ViewController.swift
//  YJFlix
//
//  Created by Yashraj on 09/02/26.
//

import UIKit
import UIKit
import FirebaseCore


class ViewController: UIViewController {

    // FB token = V9lpZcCoAoR5UUkq29zqLDU5YGa2
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //Firebase configure
        FirebaseApp.configure()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogIn(_ sender: UIButton) {
        
            gotoMainScreen()
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
