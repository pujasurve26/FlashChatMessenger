//
//  LogInViewController.swift
//  FlashChatMessenger
//
//  Created by Puja Kalpesh Surve on 21/11/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viwShadow: UIView!
    @IBOutlet weak var viwShadowPass: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContents()

    }
    
    func setContents() {
        self.title = "Login"
        viwShadow.addShadow()
        viwShadowPass.addShadow()
        
        txtEmail.becomeFirstResponder()
    }
    
    @IBAction func btnLogInTapped(_ sender: UIButton) {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
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
