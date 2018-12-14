//
//  RecruiterInfoViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse


class RecruiterInfoViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        let fNameEmpty = (self.firstNameTextField.text?.isEmpty)!
        let lNameEmpty = (self.lastNameTextField.text?.isEmpty)!
        let compNameEmpty = (self.companyNameTextField.text?.isEmpty)!
        
        if !fNameEmpty && !lNameEmpty && !compNameEmpty {
            let user = PFUser.current() as! User
            user.firstName = self.firstNameTextField.text!
            user.lastName = self.lastNameTextField.text!
            user.compayName = self.companyNameTextField.text!
            user.saveInBackground()
            self.performSegue(withIdentifier: "RecruitInfoToHub", sender: nil)
        }
    }
}
