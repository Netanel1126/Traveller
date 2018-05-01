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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbar = self.tabBarController as! GuideTabBarController
        tripId = tabbar.tripId
        if let user = DefaultUser.getUser() {
            self.usersList = TravellerUserModel.instance.data
            _ = TravellerNotification.travellerUserNotification.observe { _ in
                var myTrip = TripModel.instance.data.filter {$0.id == self.tripId}.first
                self.usersList = TravellerUserModel.instance.data.filter{(myTrip?.owners.contains($0.id))!}
                Logger.log(message: "test " +  self.usersList.description, event: .e)
                self.tableView.reloadData()
            }
        }
        self.usersList = TravellerUserModel.instance.data
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
        cell.fullName.text = usersList[index].firstName + " " + usersList[index].lastName
        cell.email.text = usersList[index].email
        // NEED TO CHANGE
        ImageFirebaseStorage.loadImage(url: usersList[index].imgUrl) { (img) in
            cell.imageURL.image = img
            self.userImages.append(img!)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        img = userImages[indexPath.row]
        self.performSegue(withIdentifier: "userInfo", sender: self.usersList[indexPath.row].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userInfo"{
            var des = segue.destination as! UserViewController
            var i = sender as! String
            var user = TravellerUserModel.instance.data.filter {$0.id == i}.first
            des.Fullname = (user?.firstName)! + " " + (user?.lastName)!
            des.Email = (user?.email)!
            des.PhoneNumber = (user?.phoneNumber)!
            des.ImageUrl = (user?.imgUrl)!
        }
    }
}
