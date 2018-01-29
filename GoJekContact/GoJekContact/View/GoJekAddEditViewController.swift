//
//  GoJekAddEditViewController.swift
//  GoJekContact
//
//  Created by muttavarapu on 27/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit

class GoJekAddEditViewController: UITableViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeNavBar() {
        //Create Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DoneContactMethod))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.green;
        
        //Create Left Bar Button
        let button = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action:nil)

        self.navigationItem.backBarButtonItem = button
        self.navigationController?.navigationBar.tintColor = UIColor.green

    }
    
    @objc func DoneContactMethod() {
        
        
    }
    
    
    @IBAction func editImageMethod(_ sender: Any) {
    }


}
