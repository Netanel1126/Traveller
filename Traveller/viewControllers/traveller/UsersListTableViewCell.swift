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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       self.imageURL.translatesAutoresizingMaskIntoConstraints = false
       self.imageURL.layer.cornerRadius = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
