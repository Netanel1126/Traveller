//
//  ViewControllerSideMenu.swift
//  Traveller
//
//  Created by sapir shloush on 26.3.2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class ContainerVC : UIViewController {
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(togleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    @objc func togleSideMenu() {
        if sideMenuOpen{
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
            
        }
        else{
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
}
