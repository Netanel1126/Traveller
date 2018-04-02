import UIKit

class TestLogOutTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelNotification.LogOutNotification.observe { (isLogOut) in
            if(isLogOut)!{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutTravller(_ sender: UIButton) {
        Model.instance.logOut()
    }
    
    @IBAction func logOutGuide(_ sender: UIButton) {
        Model.instance.logOut()
    }
    
    
}
