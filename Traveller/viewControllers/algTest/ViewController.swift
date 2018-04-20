//
//  ViewController.swift
//  Traveller
//
//  Created by admin on 04/01/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var text_X1: UITextField!
    @IBOutlet weak var text_X2: UITextField!
    @IBOutlet weak var text_X3: UITextField!
    @IBOutlet weak var text_X4: UITextField!
    @IBOutlet weak var text_X5: UITextField!
    @IBOutlet weak var text_X6: UITextField!

    @IBOutlet weak var text_Y1: UITextField!
    @IBOutlet weak var text_Y2: UITextField!
    @IBOutlet weak var text_Y3: UITextField!
    @IBOutlet weak var text_Y4: UITextField!
    @IBOutlet weak var text_Y5: UITextField!
    @IBOutlet weak var text_Y6: UITextField!
    
    @IBOutlet weak var textGuide_X1: UITextField!
    @IBOutlet weak var textRear_X2: UITextField!
    @IBOutlet weak var textMyLoc_X3: UITextField!

    @IBOutlet weak var textGuide_Y1: UITextField!
    @IBOutlet weak var textRear_Y2: UITextField!
    @IBOutlet weak var textMyLoc_Y3: UITextField!
    
    @IBOutlet weak var distanceToCheck: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CheckAlgo(_ sender: UIButton) {
        var mapPositions = [Position]()
        mapPositions.append(Position(id: 0, latitude: Double(text_X1.text!)!, longitude: Double(text_Y1.text!)!))
        mapPositions.append(Position(id: 1, latitude: Double(text_X2.text!)!, longitude: Double(text_Y2.text!)!))
        mapPositions.append(Position(id: 2, latitude: Double(text_X3.text!)!, longitude: Double(text_Y3.text!)!))
        mapPositions.append(Position(id: 3, latitude: Double(text_X4.text!)!, longitude: Double(text_Y4.text!)!))
        mapPositions.append(Position(id: 4, latitude: Double(text_X5.text!)!, longitude: Double(text_Y5.text!)!))
        mapPositions.append(Position(id: 5, latitude: Double(text_X6.text!)!, longitude: Double(text_Y6.text!)!))
        
        var guidePosition = Position(id: 1, latitude: Double(textGuide_X1.text!)!, longitude: Double(textGuide_Y1.text!)!)
        var rearPosition = Position(id: 2, latitude: Double(textRear_X2.text!)!, longitude: Double(textRear_Y2.text!)!)
        var myPosition = Position(id: 3, latitude: Double(textMyLoc_X3.text!)!, longitude: Double(textMyLoc_Y3.text!)!)
        
        var newGuidePosition = MinimumDistanceCalculator.getMinDistance(positions: mapPositions, stPos: guidePosition).1
        var newRearPosition = MinimumDistanceCalculator.getMinDistance(positions: mapPositions, stPos: rearPosition).1
        
        if(MinimumDistanceCalculator.isLegalPosition(map: mapPositions, posToCheck: myPosition, guide: newGuidePosition, rearguard: newRearPosition, maxDistance: Double(distanceToCheck.text!)!)){
            performSegue(withIdentifier: "algoTrue", sender: nil)
        }else{
            performSegue(withIdentifier: "algoFalse", sender: nil)
        }
    }
}

