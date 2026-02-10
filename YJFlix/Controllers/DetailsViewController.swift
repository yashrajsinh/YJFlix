//
//  DetailsViewController.swift
//  YJFlix
//
//  Created by Yashraj on 10/02/26.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
        
    var show: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func configure(){
        self.title = show?.name
        lblMovieDesc.text = show?.summary
        imgMoviePoster.clipsToBounds = true
        //Using SD Img
        if let imageUrlString = show?.image?.medium,
           let url = URL(string: imageUrlString) {
            imgMoviePoster.sd_setImage(with: url)
        }
    }

}
