import UIKit

class SignupViewController: ViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var backStackBackground: UIView!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var verifyPassword: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    var onComplete: ((TravellerUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        backStackBackground.layer.cornerRadius = 15
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        //configure image gesture
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(chooseImageFromGallery(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageTap)
    }
    
    @objc func chooseImageFromGallery(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            present(controller, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.profileImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: Any) {
        if verifyFields() {
            signupButton.isEnabled = false
            let imageName = "profile_\(String(describing: firstName.text))_\(String(describing: lastName.text))_\(UUID().uuidString)"
            ImageFirebaseStorage.storeImage(image: profileImage.image!, name: imageName) {
                imageUrl in
                let signupStruct = TravellerUser.SignUpStruct(email: self.email.text!, password: self.password.text!, firstName: self.firstName.text!, lastName: self.lastName.text!, phone: self.phone.text!, imgUrl: imageUrl)
                AuthManager.signUp(userStruct: signupStruct, onComplete: {
                    user in
                    self.onComplete!(user)
                }, onFailure: {
                    error in
                    let errorPopup = ErrorPopupViewController.newInstance(msg: error.localizedDescription, onComplete: { self.signupButton.isEnabled = true })
                    self.present(errorPopup, animated: true, completion: nil)
                })
            }
        }
    }
    
    func verifyFields() -> Bool {
        let user = TravellerUserModel.instance.data.filter {$0.firstName == firstName.text && $0.lastName == lastName.text}.first
        if user != nil {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "The name you chosen is already exists", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if !FieldValidation.isLegalName(str: firstName.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal first name", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if !FieldValidation.isLegalName(str: lastName.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal last name", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if !FieldValidation.isLegalEmail(str: email.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal email address", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if !FieldValidation.isValidPassword(str: password.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal password", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if password.text != verifyPassword.text {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Passwords doesnt match", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        
        if FieldValidation.isValidPhone(str: phone.text!) {
            let errorPopup = ErrorPopupViewController.newInstance(msg: "Illegal phone number", onComplete: nil)
            present(errorPopup, animated: true, completion: nil)
            return false
        }
        return true
    }
}
