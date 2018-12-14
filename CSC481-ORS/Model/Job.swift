//
//  Job.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import Foundation
import Parse

class Job : PFObject, PFSubclassing {
    @NSManaged var jobPosterId : String
    @NSManaged var jobTitle : String
    @NSManaged var jobDescrition : String
    @NSManaged var keywords : [String]
    @NSManaged var applicants : [String]
    
    override init() {
        super.init()
    }
    func initValues() {
        self.jobPosterId = String()
        self.jobTitle = String()
        self.jobDescrition = String()
        self.keywords = [String]()
        self.applicants = [String]()
    }
    func hasApplicantApplied() -> Bool {
        let userId = PFUser.current()?.objectId!
        for id in applicants {
            if id == userId {
                return true
            }
        }
        return false
    }
    func apply() {
        let userID = PFUser.current()?.objectId!
        var contains = false
        for app in applicants {
            if app == userID {
                contains = true
            }
        }
        if !contains {
            self.applicants.append(userID!)
        }
        self.saveInBackground()
    }
    func withdrawl() {
        let userId = PFUser.current()?.objectId!
        var index = -1
        for i in 0...self.applicants.count-1 {
            if applicants[i] == userId {
                index = i
            }
        }
        if index != -1 {
            applicants.remove(at: index)
        }
        self.saveInBackground()
    }
    
    static func parseClassName() -> String {
        return "Job"
    }
}
