//
//  RecruiterLogInViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/12/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse

class RecruiterLogInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogInButton(_ sender: Any) {
        let isUsernameEmpty = (self.usernameTextField.text?.isEmpty)!
        let isPasswordEmpty = (self.passwordTextField.text?.isEmpty)!
        if !isPasswordEmpty && !isUsernameEmpty {
            PFUser.logInWithUsername(inBackground: self.usernameTextField.text!, password: self.passwordTextField.text!) {
                (userLogged, error) in
                if let user = userLogged {
                    let userLogIn = user as! User
                    if userLogIn.accountType == User.recruiterType {
                        self.performSegue(withIdentifier: "RecruiterLogInToHub", sender: nil)
                    } else {
                        PFUser.logOut()
                    }
                }
            }
        }
        
    }
    


}
