import UIKit

class TestLogOutTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutTravller(_ sender: UIButton) {
        AuthManager.logout() {
            if $0 == true {
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func logOutGuide(_ sender: UIButton) {
        AuthManager.logout() {
            if $0 == true {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}
