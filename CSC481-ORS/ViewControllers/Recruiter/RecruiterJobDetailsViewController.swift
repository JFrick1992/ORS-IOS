//
//  RecruiterJobDetailsViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class RecruiterJobDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var applicantTableView: UITableView!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    
    var applicants = [User]()
    var userToSend = User()
    
    var job = Job()  {
        didSet {
            self.title = job.jobTitle
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applicantTableView.delegate = self
        self.applicantTableView.dataSource = self
        self.applicantTableView.layer.borderWidth = 3
        self.applicantTableView.layer.borderColor = UIColor.lightGray.cgColor
        self.jobDescriptionTextView.text = job.jobDescrition
        self.jobDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.jobDescriptionTextView.layer.borderWidth = 2
        self.jobDescriptionTextView.layer.backgroundColor = UIColor.white.cgColor
        self.fetchApplicants()
    }
    
    func fetchApplicants() {
        let query = User.query()
        query?.whereKey("objectId", containedIn: job.applicants)
        query?.findObjectsInBackground(block: { (userApps, error) in
            if let user = userApps {
                self.applicants = user as! [User]
                self.applicantTableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.applicants.count > 0 {
            return self.applicants.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.applicantTableView.dequeueReusableCell(withIdentifier: "ApplicantNameCell", for: indexPath) as! ApplicantCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if self.applicants.count > 0 {
            cell.applicantNameLabel.text = "\(self.applicants[indexPath.row].firstName) \(self.applicants[indexPath.row].lastName)"
        } else {
            cell.applicantNameLabel.text = "No applicants yet"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userToSend = self.applicants[indexPath.row]
        self.performSegue(withIdentifier: "viewApplicantsInfo", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewApplicantsInfo" {
            let dest = segue.destination as! UINavigationController
            let vc = dest.topViewController as! RecruiterViewApplicantProfileViewController
            vc.user = self.userToSend
        }
    }
}
