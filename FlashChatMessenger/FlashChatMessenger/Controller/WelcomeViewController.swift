//
//  WelcomeViewController.swift
//  FlashChatMessenger
//
//  Created by Puja Kalpesh Surve on 21/11/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var lblFashChat: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblFashChat.text = ""
        var charIndex = 0.0
        let titleText = K.appName
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                self.lblFashChat.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func btnLogInTapped(_ sender: UIButton) {
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
