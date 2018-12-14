//
//  User.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/12/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import Foundation
import Parse


class User : PFUser {
    static let recruiterType = "recruiter"
    static let applicantType = "applicant"
    static let adminType = "admin"
    
    @NSManaged var accountType : String
    @NSManaged var firstName : String
    @NSManaged var lastName : String
    
    //Recuiter Specific Info Here
    @NSManaged var compayName : String
    @NSManaged var jobsPosted : [String]
    
    //Applicant Specific Info Here
    @NSManaged var resume : String
    @NSManaged var userEmail : String
    
    override init() {
        super.init()
    }
}
