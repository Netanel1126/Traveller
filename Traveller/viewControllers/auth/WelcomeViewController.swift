
import UIKit

class WelcomeViewController: ViewController {
    
    @IBOutlet weak var stackviewBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackviewBackground.layer.cornerRadius = 15

//        contentContainer.layer.borderColor = UIColor.white.cgColor
//        contentContainer.layer.borderWidth = 2
//        contentContainer.layer.cornerRadius = 18
        if let user = DefaultUser.getUser() {
            toDashboard(user: user)
        }
    }
    
    func toDashboard(user: TravellerUser){
        performSegue(withIdentifier: "homeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            let vc = segue.destination as! LoginViewController
            vc.onComplete = {
                DefaultUser.setUser(user: $0)
                self.toDashboard(user: $0)
            }
        } else if segue.identifier == "signupSegue" {
            let vc = segue.destination as! SignupViewController
            vc.onComplete = {
                DefaultUser.setUser(user: $0)
                self.toDashboard(user: $0)
            }
        }
    }
    
    @IBAction func unwindToAuth(segue:UIStoryboardSegue) {
        DefaultUser.setUser(user: nil)
    }

}
