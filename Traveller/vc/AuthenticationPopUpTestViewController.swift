import UIKit

class AuthenticationPopUpTestViewController: UIViewController {

    @IBOutlet weak var authenticationText: UITextField!
    var user:TravellerGuide?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationInit()
        Model.instance.getConnectedUserAndObserve()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func chackAuthentication(_ sender: Any) {
        user?.authentication = authenticationText.text!
        Model.instance.checkAuthentication(user: user!)
    }
    
    @IBAction func continueWithoutEntering(_ sender: UIButton) {
        let travellerHomePage = self.storyboard?.instantiateViewController(withIdentifier: "Traveller_HomeScreen") as! TestLogOutTestViewController
        self.present(travellerHomePage, animated: true, completion: nil)
    }
    
    func notificationInit(){
        ModelNotification.AuthenticationNotification.observe { (error) in
            if error != ""{
                print(error)
            }else{
                let travellerHomePage = self.storyboard?.instantiateViewController(withIdentifier: "Guide_HomeScreen") as! TestLogOutTestViewController
                self.present(travellerHomePage, animated: true, completion: nil)
            }
        }
        
        ModelNotification.ConnectedUser.observe { (userFromFB) in
            self.user = TravellerGuide()
            self.user?.TravellerToGuide(user: userFromFB!)
        }
    }
}
