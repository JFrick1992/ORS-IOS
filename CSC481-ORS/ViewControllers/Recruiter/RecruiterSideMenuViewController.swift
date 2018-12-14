//
//  RecruiterSideMenuViewController.swift
//  CSC481-ORS
//
//  Created by Jacob Frick on 12/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import SideMenu
import Parse

class RecruiterSideMenuViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size.width = 200
        
        self.logOutButton.layer.borderColor = UIColor.lightGray.cgColor
        self.logOutButton.layer.borderWidth = 2
        SideMenuManager.defaultManager.menuWidth = 200
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SideMenuManager.defaultManager.menuWidth = 200
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func didTapLogOut(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "AppSideMenuLogOut", sender: nil)
    }
    

}
