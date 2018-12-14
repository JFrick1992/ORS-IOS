//
//  ApplicantJobDetailsViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class ApplicantJobDetailsViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var applyWithdrawlButton: UIButton!
    
    var userStatus = false
    var job = Job() {
        didSet {
            self.title = job.jobTitle
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userStatus = job.hasApplicantApplied()
        self.updateButton()
        self.descriptionTextView.text = job.jobDescrition
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapApplyWithdrawl(_ sender: Any) {
        if self.userStatus {
            job.withdrawl()
            self.userStatus = false
            self.updateButton()
        } else {
            job.apply()
            self.userStatus = true
            self.updateButton()
        }
    }
    func updateButton() {
        if self.userStatus {
            self.applyWithdrawlButton.setTitle("Withdrawl", for: .normal)
        } else {
            self.applyWithdrawlButton.setTitle("Apply", for: .normal)
        }
    }
}
