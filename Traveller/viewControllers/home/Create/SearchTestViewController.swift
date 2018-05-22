//
//  SearchTestViewController.swift
//  Traveller
//
//  Created by Tal Sahar on 21/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit
import RAMReel
@available(iOS 8.2, *)
class SearchViewController: ViewController {
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    @IBOutlet weak var errorLabel: UILabel!
    var onChooseDelegate: ((TravellerUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = DefaultUser.getUser()
        let data = TravellerUserModel.instance.data.filter { user?.id != $0.id }.map {($0.firstName + " " + $0.lastName).lowercased()}
        dataSource = SimplePrefixQueryDataSource(data)
        
        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
            self.onChosen(str: $0)
        }
        
        view.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    @IBAction func chooseTapped(_ sender: Any) {
        onChosen(str: ramReel.selectedItem!)
    }
    
    func onChosen(str: String) {
        if !dataSource.resultsForQuery(str).contains(str) {
            errorLabel.text = "Please check your spell"
        } else {
            let chosenUser = TravellerUserModel.instance.data.filter { ($0.firstName + " " + $0.lastName).lowercased() == str }.first
            onChooseDelegate!(chosenUser!)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
