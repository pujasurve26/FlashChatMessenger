//
//  RegisterViewController.swift
//  FlashChatMessenger
//
//  Created by Puja Kalpesh Surve on 21/11/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viwShadow: UIView!
    @IBOutlet weak var viwShadowPass: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContent()
    }
    
    func setContent() {
        self.title = "Register"
        
        viwShadow.addShadow()
        viwShadowPass.addShadow()
        
        txtEmail.becomeFirstResponder()
        view.backgroundColor = .purple
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let auth = authResult {
                    
                    //Navigation to chat viewController
                    let story = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else {
                    print("FAILURE:", error?.localizedDescription)
                }
            }
        }
    }
}

extension UIView {
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = self.frame.height / 2
    }
}
