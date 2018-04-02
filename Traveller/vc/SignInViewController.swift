import UIKit

class SignInViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var fNameText: UITextField!
    @IBOutlet weak var LnameText: UITextField!
    @IBOutlet weak var phoneNumText: UITextField!
    @IBOutlet weak var authenticationText: UITextField!
    
    @IBOutlet weak var userIMG: UIImageView!
    var selectedImage: UIImage?
    var isTraveller = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationText.isHidden = isTraveller
        
        notificationInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        var user:TravellerUser
        user = TravellerUser(userName: usernameText.text!, email: emailText.text!, password: passwordText.text!, firstName: fNameText.text!, lastName: LnameText.text!, phoneNumber: phoneNumText.text!, imgURL: nil)
        user.userType = "Traveller"
        
        Model.instance.addNewUserToDatabase(user: user, image: self.selectedImage, name: self.usernameText.text)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.userIMG.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func getImageFromGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            present(controller, animated: true, completion: nil)
        }
    }

    func notificationInit(){
        ModelNotification.NewUserNotification.observe { (error) in
            if error != nil && error != ""{
                print(error)
                /*ToDo - add Popup for user*/
            }else{
                print("User: " + (self.usernameText.text)! + " is logged in")
                if(self.isTraveller){
                    let travellerHomePage = self.storyboard?.instantiateViewController(withIdentifier: "Traveller_HomeScreen") as! TestLogOutTestViewController
                    self.present(travellerHomePage, animated: true, completion: nil)
                    /*Create Transition to Guide Home page*/
                }else{
                    let travellerHomePage = self.storyboard?.instantiateViewController(withIdentifier: "AuthenticationPopUp") as! AuthenticationPopUpTestViewController
                    self.present(travellerHomePage, animated: true, completion: nil)
                    /*Create Transition to Traveller Home page*/
                }
            }
        }
    }
}
