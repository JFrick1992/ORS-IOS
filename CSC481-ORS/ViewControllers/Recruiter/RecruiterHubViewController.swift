//
//  RecuiterHubViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse
class RecruiterHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sideMenu: UIView!
    var isMenuOut = false
    var jobToSend = Job()
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var mainViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var interviewButton: UIButton!
    
    @IBOutlet weak var jobtTitleTableView: UITableView!
    
    var jobs = [Job]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.jobtTitleTableView.delegate = self
        self.jobtTitleTableView.dataSource = self
        self.fetchJobs()
        self.logOutButton.layer.borderWidth = 2
        self.logOutButton.layer.borderColor = UIColor.white.cgColor
        
        self.profileButton.layer.borderWidth = 2
        self.profileButton.layer.borderColor = UIColor.white.cgColor
        
        self.createButton.layer.borderWidth = 2
        self.createButton.layer.borderColor = UIColor.white.cgColor
        
        self.interviewButton.layer.borderWidth = 2
        self.interviewButton.layer.borderColor = UIColor.white.cgColor
        self.jobtTitleTableView.layer.borderColor = UIColor.lightGray.cgColor
        self.jobtTitleTableView.layer.borderWidth = 3
    }

    @IBAction func didTapMenu(_ sender: Any) {
        if self.isMenuOut {
            self.sideMenuLeadingConstraint.constant = -180
            self.mainViewTrailingConstraint.constant = 0
            self.isMenuOut = false
        } else {
            self.sideMenuLeadingConstraint.constant = 0
            self.mainViewTrailingConstraint.constant = 180
            self.isMenuOut = true
        }
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
    }
    func fetchJobs() {
        let user = PFUser.current() as! User
        let query = Job.query()
        query?.whereKey("objectId", containedIn: user.jobsPosted)
        query?.findObjectsInBackground(block: { (jobsFound, error) in
            if let jobs = jobsFound {
                self.jobs = jobs as! [Job]
                self.jobtTitleTableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    @IBAction func didTapLogOut(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "recruitLogOutSegue", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.jobs.count > 0 {
            return self.jobs.count
        } else {
            return 1
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.jobtTitleTableView.dequeueReusableCell(withIdentifier: "RecJobTitleCell", for: indexPath) as! RecJobTitleCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if self.jobs.count > 0 {
            cell.jobtTitleLabel.text = self.jobs[indexPath.row].jobTitle
        } else {
            cell.jobtTitleLabel.text = "No Jobs Posted"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.jobs.count > 0 {
            self.jobToSend = self.jobs[indexPath.row]
            self.performSegue(withIdentifier: "RecHubToJobDetails", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecHubToJobDetails" {
            let dest = segue.destination as! UINavigationController
            let vc = dest.topViewController as! RecruiterJobDetailsViewController
            vc.job = self.jobToSend
    

            
        }
    }
}
