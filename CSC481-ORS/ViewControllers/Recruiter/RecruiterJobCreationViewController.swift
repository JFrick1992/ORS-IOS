//
//  RecruiterJobCreationViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse

class RecruiterJobCreationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var jobtTitleField: UITextField!
    @IBOutlet weak var jobDescriptionField: UITextView!
    
    @IBOutlet weak var keywordField: UITextField!
    
    var keywords = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keywordTableView.dataSource = self
        self.keywordTableView.delegate = self
        
        self.jobDescriptionField.layer.backgroundColor = UIColor.white.cgColor
        self.jobDescriptionField.layer.borderColor = UIColor.lightGray.cgColor
        self.jobDescriptionField.layer.borderWidth = 2
        
        self.keywordField.layer.borderWidth = 2
        self.keywordField.layer.borderColor = UIColor.lightGray.cgColor
        
        self.jobtTitleField.layer.borderWidth = 2
        self.jobtTitleField.layer.borderColor = UIColor.lightGray.cgColor
        
        self.keywordTableView.layer.borderWidth = 2
        self.keywordTableView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
 
    @IBAction func didTapAddKeyword(_ sender: Any) {
        if !(self.keywordField.text?.isEmpty)! {
            self.keywords.append(self.keywordField.text!)
            self.keywordField.text = ""
            self.keywordTableView.reloadData()
        }
        
    }
    @IBAction func didTapCreate(_ sender: Any) {
        let isJobTitleEmpty = (self.jobtTitleField.text?.isEmpty)!
        let isJobDescriptEmpty = (self.jobDescriptionField.text.isEmpty)
        
        if !isJobTitleEmpty && !isJobDescriptEmpty {
            let job = Job()
            job.initValues()
            job.keywords = self.keywords
            job.jobTitle = self.jobtTitleField.text!
            job.jobDescrition = self.jobDescriptionField.text
            job.jobPosterId = (PFUser.current()?.objectId)!
            job.saveInBackground { (success, error) in
                if success {
                    let user = PFUser.current() as! User
                    user.jobsPosted.append(job.objectId!)
                    user.saveInBackground()
                    self.performSegue(withIdentifier: "backToRecruiterHub", sender: nil)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }

        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.keywords.count > 0 {
            return self.keywords.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.keywordTableView.dequeueReusableCell(withIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if self.keywords.count > 0 {
            cell.keywordLabel.text = self.keywords[indexPath.row]
        } else {
            cell.keywordLabel.text = "No Keywords added"
        }
        
        return cell
    }
    
}
