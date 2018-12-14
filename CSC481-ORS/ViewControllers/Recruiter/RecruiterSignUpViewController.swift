//
//  RecruiterSignUpViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/12/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class RecruiterSignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapRegisterButton(_ sender: Any) {
        let usernameEmpty = (self.usernameTextField.text?.isEmpty)!
        let passwordEmpty = (self.passwordTextField.text?.isEmpty)!
        let emailEmpty = (self.emailTextField.text?.isEmpty)!
        
        if !usernameEmpty && !passwordEmpty && !emailEmpty {
            let user = User()
            user.username = self.usernameTextField.text!
            user.password = self.passwordTextField.text!
            user.email = self.emailTextField.text!
            user.jobsPosted = [String]()
            user.signUpInBackground { (success, error) in
                if success {
                    user.accountType = User.recruiterType
                    user.saveInBackground()
                    self.performSegue(withIdentifier: "RecruitSignUpToInfo", sender: nil)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    

}
