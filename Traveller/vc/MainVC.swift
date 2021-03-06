//
//  MainVC.swift
//  Traveller
//
//  Created by sapir shloush on 26/03/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

// Defines the notifications for displaying the side menus and performing segues to them.
// Connected to SideMenu.storyboard
class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
                NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("ShowProfile"), object: nil)
        
                NotificationCenter.default.addObserver(self, selector: #selector(showSettings), name: NSNotification.Name("ShowSettings"), object: nil)
        
                NotificationCenter.default.addObserver(self, selector: #selector(showSignIn), name: NSNotification.Name("ShowSignIn"), object: nil)
        
    }
    
    @objc func showProfile(){
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    @objc func showSettings(){
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    @objc func showSignIn(){
        performSegue(withIdentifier: "ShowSignIn", sender: nil)
    }
    
    @IBAction func onMoreTapped(){
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    

}
