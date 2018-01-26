//
//  GoJekCustomCell.swift
//  GoJekContact
//
//  Created by muttavarapu on 26/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit

class GoJekCustomCell: UITableViewCell {

    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactImg: UIImageView!
    @IBOutlet weak var contactFavourite: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contactImg.layer.cornerRadius = contactImg.frame.size.width/2
        contactImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var item: ContactItem? {
        didSet {
            if let item = item {
                contactTitle.text = item.firstName
                contactImg.imageFromServerURL(urlString: "http://gojek-contacts-app.herokuapp.com/\(item.profilePic)", defaultImage: "noImg")
                if item.favorite == 1
                {
                    contactFavourite.isHidden = false;
                    contactFavourite.image = UIImage(named: "fav")
                }else{
                    contactFavourite.isHidden = true;
                }
            } else {
                contactTitle.text = "Unknown"
            }
        }
    }

}
