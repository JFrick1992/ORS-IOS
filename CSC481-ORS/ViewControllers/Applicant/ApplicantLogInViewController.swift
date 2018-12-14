//
//  ApplicantViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/12/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse

class ApplicantLogInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLogInButton(_ sender: Any) {
        let usernameEmpty = (self.usernameTextField.text?.isEmpty)!
        let passwordEmpty = (self.passwordTextField.text?.isEmpty)!
        if !usernameEmpty && !passwordEmpty {
            PFUser.logInWithUsername(inBackground: self.usernameTextField.text!, password: self.passwordTextField.text!) {
                (userLogIn, error) in
                if let userLogIn = userLogIn {
                    let user = userLogIn as! User
                    if user.accountType == User.applicantType {
                        self.performSegue(withIdentifier: "AppLogInToHub", sender: nil)
                    } else {
                        print("incorrect type")
                        PFUser.logOut()
                    }
                }
            }
        }
    }
    
}
