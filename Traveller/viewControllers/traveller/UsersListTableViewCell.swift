//
//  UsersListTableViewCell.swift
//  Traveller
//
//  Created by Darkidan on 29/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var imageURL: UIImageView!
    var phone: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //circled image
        imageURL.layer.borderWidth = 1
        imageURL.layer.masksToBounds = false
        imageURL.layer.borderColor = UIColor.gray.cgColor
        imageURL.layer.cornerRadius = imageURL.frame.height/2
        imageURL.clipsToBounds = true
    }
    
    @IBAction func callTapped(_ sender: Any) {
        if let phone = phone {
            guard let number = URL(string: "tel://" + phone) else { return }
            UIApplication.shared.open(number)
        }
    }
    
}
