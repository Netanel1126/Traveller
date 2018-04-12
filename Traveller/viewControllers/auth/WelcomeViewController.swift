
import UIKit

class WelcomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        AuthManager.getConnectedUser() { user in
//            if user != nil {
//                self.toDashboard(user: user!)
//            }
//        }
    }
    
    func toDashboard(user: TravellerUser){
        Logger.log(message: "User \(user.email) has logged in", event: .i)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainDashboard")
        self.present(controller, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            let vc = segue.destination as! LoginViewController
            vc.onComplete = { self.toDashboard(user: $0) }
            } else if segue.identifier == "signupSegue" {
            let vc = segue.destination as! SignupViewController
            vc.onComplete = { self.toDashboard(user: $0) }
        }
    }
}
