
import UIKit

// Shows Home page
// Connected to LoginAndGuideHomePage.storyboard
class WelcomeViewController: UIViewController {

    @IBOutlet weak var guideOrUser: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelNotification.ConnectedUser.observe { (user) in
            if user != nil{
                print("User: " + (user?.userName)! + " is logged in")
                print("User Type: " + (user?.userType)!)
                if user?.userType == "Guide"{
                    /*Create Transition to Guide Home page*/
                }else{
                    /*Create Transition to Traveller Home page*/
                }
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        Model.instance.getConnectedUserAndObserve()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToSignInView"{
            let destViewController = segue.destination as! SignInViewController
            
            if guideOrUser.selectedSegmentIndex == 0{
                destViewController.isTraveller = false
            }else{
                destViewController.isTraveller = true
            }
        }
    }
    
    @IBAction func moveTo_SignIn(_ sender: Any) {
        self.performSegue(withIdentifier: "moveToSignInView", sender: nil)
    }
}
