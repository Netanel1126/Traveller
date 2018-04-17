

import Foundation
import UIKit
class GroupTableViewController: UITableViewController  {
    
    public var joinedGroups = [Group]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelerGroupsCell", for: indexPath)
        
        cell.textLabel?.text = joinedGroups[indexPath.row].groupName
        
        return cell
    }

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
