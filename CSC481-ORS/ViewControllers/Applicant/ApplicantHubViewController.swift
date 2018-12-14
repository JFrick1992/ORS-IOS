//
//  ApplicantHubViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse

class ApplicantHubViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var mainViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    var jobs = [Job]()
    var isMenuOut = false
    var jobToSend = Job()
    @IBOutlet weak var jobListingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jobListingTableView.delegate = self
        self.jobListingTableView.dataSource = self
        self.jobListingTableView.layer.borderColor = UIColor.lightGray.cgColor
        self.jobListingTableView.layer.borderWidth = 3
        self.fetchJobs()
        // Do any additional setup after loading the view.
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
    @IBAction func didTapLogOut(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "AppToMainPage", sender: nil)
    }
    func fetchJobs() {
        let query = Job.query()
        query?.limit = 100
        query?.addAscendingOrder("createdAt")
        query?.findObjectsInBackground(block: { (jobsFound, error) in
            if let jobs = jobsFound {
                self.jobs = jobs as! [Job]
                self.jobListingTableView.reloadData()
            } else if let error = error{
                print(error.localizedDescription)
            }
        })
    }
    @IBAction func didTapInterviews(_ sender: Any) {
    }
    @IBAction func didTapApplied(_ sender: Any) {
    }
    @IBAction func didTapProfile(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.jobs.count > 0 {
            return self.jobs.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.jobListingTableView.dequeueReusableCell(withIdentifier: "JobTitleCell", for: indexPath) as! AppJobTitleCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if self.jobs.count > 0 {
            cell.jobTitleLabel.text = self.jobs[indexPath.row].jobTitle
        } else {
            cell.jobTitleLabel.text = "No Job Openings Posted"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.jobToSend = self.jobs[indexPath.row]
        self.performSegue(withIdentifier: "AppViewJobs", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AppViewJobs" {
            let dest = segue.destination as! UINavigationController
            let vc = dest.topViewController as! ApplicantJobDetailsViewController
            vc.job = self.jobToSend
            
        }
    }
}
