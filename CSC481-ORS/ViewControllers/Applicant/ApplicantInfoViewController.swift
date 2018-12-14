//
//  ApplicantInfoViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse

class ApplicantInfoViewController: UIViewController {

    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var applicantResumeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapContinue(_ sender: Any) {
        let fNameEmpty = (self.firstNameField.text?.isEmpty)!
        let lNameEmpty = (self.lastNameField.text?.isEmpty)!
        let reEmpty = self.applicantResumeTextView.text.isEmpty
        if !fNameEmpty && !lNameEmpty && !reEmpty {
            let user = PFUser.current() as! User
            user.firstName = self.firstNameField.text!
            user.lastName = self.lastNameField.text!
            user.resume = self.applicantResumeTextView.text
            user.saveInBackground()
            self.performSegue(withIdentifier: "AppInfoToHub", sender: nil)
        }
    }
    


}
