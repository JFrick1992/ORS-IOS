//
//  RecruiterProfileViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse
class RecruiterProfileViewController: UIViewController {
 
    @IBOutlet weak var editAndSaveButton: UIBarButtonItem!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    var isInEditingMode = false
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = PFUser.current() as! User
        self.companyNameField.text = user.compayName
        self.emailField.text = user.email!
        self.lastNameField.text = user.lastName
        self.firstNameField.text = user.firstName
        self.title = "\((user.username)!) Profile"
        
        self.companyNameField.layer.borderColor = UIColor.lightGray.cgColor
        self.lastNameField.layer.borderColor = UIColor.lightGray.cgColor
        self.firstNameField.layer.borderColor = UIColor.lightGray.cgColor
        self.emailField.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapEditOrSave(_ sender: Any) {
        if isInEditingMode {
            self.editAndSaveButton.title = "Edit"
            self.isInEditingMode = false
            
            self.companyNameField.layer.borderWidth = 0
            self.lastNameField.layer.borderWidth = 0
            self.firstNameField.layer.borderWidth = 0
            self.emailField.layer.borderWidth = 0
            self.lastNameField.isUserInteractionEnabled = false
            self.emailField.isUserInteractionEnabled = false
            self.firstNameField.isUserInteractionEnabled = false
            self.companyNameField.isUserInteractionEnabled = false
            if !(self.firstNameField.text?.isEmpty)! {
                self.user.firstName = self.firstNameField.text!
            }
            if !(self.lastNameField.text?.isEmpty)! {
                self.user.lastName = self.lastNameField.text!
            }
            if !(self.companyNameField.text?.isEmpty)! {
                self.user.compayName = self.companyNameField.text!
            }
            if !(self.emailField.text?.isEmpty)! {
                self.user.email = self.emailField.text!
            }
            self.user.saveInBackground()
        } else {
            self.editAndSaveButton.title = "Save"
            self.isInEditingMode = true
            self.companyNameField.layer.borderWidth = 2
            self.lastNameField.layer.borderWidth = 2
            self.firstNameField.layer.borderWidth = 2
            self.emailField.layer.borderWidth = 2
            self.lastNameField.isUserInteractionEnabled = true
            self.emailField.isUserInteractionEnabled = true
            self.firstNameField.isUserInteractionEnabled = true
            self.companyNameField.isUserInteractionEnabled = true
        }
    }
    

}
