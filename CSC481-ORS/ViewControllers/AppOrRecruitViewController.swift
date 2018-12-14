//
//  ApplOrRecruitViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/12/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import Parse

class AppOrRecruitViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screen = UIScreen.main.bounds
        
        //Create the top half view for hr rep
        let newTopView = UIView()
        newTopView.frame.size.height = screen.height/2
        newTopView.frame.size.width = screen.width
        newTopView.backgroundColor = UIColor.red
        
        //Create the bottom half view for applicant
        let newBottomView = UIView()
        newBottomView.frame.size.height = screen.height/2
        newBottomView.frame.size.width = screen.width
        newBottomView.backgroundColor = UIColor.blue
        newBottomView.center.y = screen.height*0.75
        
        //Create the label for hr rep
        let hrLabel = UILabel(frame: CGRect(x: newTopView.frame.size.width/2-100, y: newTopView.frame.size.height/2-10, width: 200, height: 40))
        hrLabel.textAlignment = .center
        hrLabel.font = UIFont(descriptor: hrLabel.font.fontDescriptor, size: 45)
        hrLabel.text = "Recruiter"
        
        //Create the label for applicant
        let ApplicantLabel = UILabel(frame: CGRect(x: newBottomView.frame.size.width/2-100, y: newBottomView.frame.size.height/2-10, width: 200, height: 40))
        ApplicantLabel.textAlignment = .center
        ApplicantLabel.font = UIFont(descriptor: hrLabel.font.fontDescriptor, size: 45)
        ApplicantLabel.text = "Applicant"
        
        //Create applicant tap gesture recognizer
        let applicantTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapApplicantView(_:)))
        applicantTapGesture.delegate = self
        
        //Create hr rep tap gesture recognizer
        let hrTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapRecruiterView(_:)))
        hrTapGesture.delegate = self
        
        //Add hr label and tap gesture to top view, then add top view to main view
        newTopView.addSubview(hrLabel)
        newTopView.addGestureRecognizer(hrTapGesture)
        self.view.addSubview(newTopView)
        
        //Add applicant label and tap gesture to bottom view then add bottom view to main view
        newBottomView.addSubview(ApplicantLabel)
        newBottomView.addGestureRecognizer(applicantTapGesture)
        self.view.addSubview(newBottomView)
    }

    @IBAction func didTapRecruiterView(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "MainPageToRecruiterLogIn", sender: nil)
    }
    @IBAction func didTapApplicantView(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "MainToAppLogIn", sender: nil)
    }

}
