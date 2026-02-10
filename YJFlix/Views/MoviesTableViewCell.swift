//
//  MoviesTableViewCell.swift
//  YJFlix
//
//  Created by Yashraj on 10/02/26.
//

import SDWebImage
import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!

    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var lblDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //to show img properly
        polishUI()
    }

    func polishUI() {
        // Rounded cell
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        // Shadow (Android elevation feel)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false

        // Image styling
        imgUser.layer.cornerRadius = 8
        imgUser.clipsToBounds = true
        selectionStyle = .none
    }
    func configureCell(with data: Show) {

        //Using SD Img
        if let imageUrlString = data.image?.medium,
            let imgURL = URL(string: imageUrlString)
        {
            imgUser.sd_setImage(with: imgURL)
        }
        self.lblTitle.text = data.name
        self.lblDesc.text = data.summary
    }
}
