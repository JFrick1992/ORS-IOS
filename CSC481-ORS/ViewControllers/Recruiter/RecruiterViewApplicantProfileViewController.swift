//
//  RecruiterViewApplicantProfileViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class RecruiterViewApplicantProfileViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var resumeTextView: UITextView!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstName.text = user.firstName
        self.lastNameLabel.text = user.lastName
        self.emailLabel.text = user.userEmail
        self.resumeTextView.text = user.resume
    }
    


}
