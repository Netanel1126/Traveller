

import UIKit

class UserLocatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var a = Algo()
        
        print("Test: \(a.locator(pointA:Location(x:8,y:3),pointB:Location(x:4,y:8)))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
