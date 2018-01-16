//
//  GroupTableViewController.swift
//  Traveller
//
//  Created by sapir shloush on 16.1.2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import UIKit
class GroupTableViewController: UITableViewController  {
    

// method to run when table view cell is tapped
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // Segue to the second view controller
    self.performSegue(withIdentifier: "ToJoinGroup", sender: self)
}

// This function is called before the segue
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    // get a reference to the second view controller
    let secondViewController = segue.destination as! JoinGroupController
    
    
    }
}
