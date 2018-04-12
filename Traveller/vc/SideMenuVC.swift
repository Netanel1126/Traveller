//
//  SideMenuVC.swift
//  Traveller
//
//  Created by sapir shloush on 26.3.2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

// Manages the displaying of the SideMenu options.
// Connected to SideMenu.storyboard
class SideMenuVC: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
         NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row{
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowSignIn"), object: nil)
        default: break
        }
    }

   
}
