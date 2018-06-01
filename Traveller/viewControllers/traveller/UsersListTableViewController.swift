//
//  UsersListTableViewController.swift
//  Traveller
//
//  Created by Darkidan on 29/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class UsersListTableViewController: UITableViewController {

    var userImages = [UIImage]()
    var img: UIImage?
    var usersList = [TravellerUser]()
    var tripId:String?
    var users:TripUsers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
        let tabbar = self.tabBarController as! GuideTabBarController
        tripId = tabbar.tripId
        users = TripUsers(groupId: tripId!)
        self.usersList = (users?.users)!
        
        TravellerNotification.tripUsersNotification.observe { (_) in
            self.usersList = (self.users?.users)!
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return usersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersList", for: indexPath) as! UsersListTableViewCell
        let index = indexPath.row
        var user = usersList[index]
        cell.fullName.text = user.fullname()
        cell.email.text = user.email
        cell.imageURL.image = users?.usersImages[user.id]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "userInfo", sender: self.usersList[indexPath.row].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userInfo"{
            let des = segue.destination as! UserViewController
            let i = sender as! String
            let user = TravellerUserModel.instance.data.filter {$0.id == i}.first
            des.Fullname = (user?.firstName)! + " " + (user?.lastName)!
            des.Email = (user?.email)!
            des.PhoneNumber = (user?.phoneNumber)!
            des.Image = users?.usersImages[(user?.id)!]
        }
    }
}
