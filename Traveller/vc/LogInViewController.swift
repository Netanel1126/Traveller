import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logIn(_ sender: UIButton) {
        Model.instance.logInAndObserve(withEmail: userName.text!, password: password.text!)
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        /*Todo*/
    }
    
    func notificationInit(){
        
        ModelNotification.ConnectedUser.observe { (user) in
            if user != nil{
                print("User: " + (user?.userName)! + " is logged in")
                print("User Type: " + (user?.userType)!)
                if user?.userType == "Guide"{
                    
                    let travellerHomePage = self.storyboard?.instantiateViewController(withIdentifier: "Guide_HomeScreen") as! TestLogOutTestViewController
                    self.present(travellerHomePage, animated: true, completion: nil)
                    
                    /*Create Transition to Guide Home page*/
                }else{
                    let travellerHomePage = self.storyboard?.instantiateViewController(withIdentifier: "Traveller_HomeScreen") as! TestLogOutTestViewController
                    self.present(travellerHomePage, animated: true, completion: nil)
                   
                    /*Create Transition to Traveller Home page*/
                }
            }
        }
        
        ModelNotification.LogInNotification.observe { (error) in
            if error != nil && error != ""{
                print(error)
                /*ToDo - add Popup for user*/
            }else{
                Model.instance.getConnectedUserAndObserve()
            }
        }
    }
}
