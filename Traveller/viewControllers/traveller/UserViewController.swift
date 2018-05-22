//
//  UserViewController.swift
//  Traveller
//
//  Created by Darkidan on 29/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class UserViewController: ViewController {

    @IBOutlet weak var imageurl: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var Fullname: String?
    var Email: String?
    var PhoneNumber: String?
    var ImageUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImg()
        spinner.startAnimating()
        fullname.text = Fullname
        email.text = Email
        phoneNumber.text = PhoneNumber
        }

    func addImg(){
    ImageFirebaseStorage.loadImage(url: ImageUrl!) { (img) in
            self.imageurl.image = img
            self.imageurl.isHidden = false
            self.spinner.isHidden = true
        Logger.log(message: self.Fullname! + " Img was add", event: .d)
        }
    }
    
    @IBAction func backToUserList(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
