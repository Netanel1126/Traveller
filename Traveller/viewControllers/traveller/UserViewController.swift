//
//  UserViewController.swift
//  Traveller
//
//  Created by Darkidan on 29/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class UserViewController: ViewController {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var imageurl: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var Fullname: String?
    var Email: String?
    var PhoneNumber: String?
    var Image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderView.layer.cornerRadius = 10
        self.imageurl.image = Image
        fullname.text = Fullname
        email.text = Email
        phoneNumber.text = PhoneNumber
    }

    @IBAction func callTappede(_ sender: Any) {
        if let phoneNumber = phoneNumber.text {
            guard let number = URL(string: "tel://" + phoneNumber) else { return }
            UIApplication.shared.open(number)
        }
    }
    
}
