//
//  GoJekAddEditViewController.swift
//  GoJekContact
//
//  Created by muttavarapu on 27/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit

class GoJekAddEditViewController: UITableViewController{
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    var isEdit: Bool?
    var editContact: ContactItem?
    
    // AddEditViewModel local variables
    private let viewModel = GoJekAddEditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()

        //Set delegate for callback after receiving reponse from viewomdel
        viewModel.viewDelegate = self

        //checking condition for display edit or new
        if let edit = isEdit {
            if edit
            {
                refreshDisplay()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeNavBar() {
        //Create Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DoneContactMethod))
        
        //Create Left Bar Button
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DismissalMethod))
        self.navigationController?.navigationBar.tintColor = UIColor.green

    }
    
    @objc func DismissalMethod(){
        guard navigationController?.popViewController(animated: true) != nil else { //modal
            dismiss(animated: true, completion: nil)
            return
        }
    }
    @objc func DoneContactMethod() {
        
        if let text = firstNameText.text, text.isEmpty
        {
           print("Please enter first Name")
        }else if let text = lastNameText.text, text.isEmpty
        {
            print("Please enter last name")

        }else if let text = emailText.text, text.isEmpty
        {
            print("Please enter email Id")
            
        }else if let text = mobileText.text, text.isEmpty
        {
            print("Please enter mobile number")
            
        }else
        {
            self.showDataLoadingProgressHUD()
            if let edit = isEdit {
                if edit
                {
                    editContact?.firstName = firstNameText.text!
                    editContact?.lastName = lastNameText.text!
                    editContact?.emailId = emailText.text!
                    editContact?.phoneNumber = mobileText.text!
                    viewModel.updatedContactDetailToServer(detail: editContact)

                }else{
                    
                    editContact = ContactItem(id: 0, firstName: firstNameText.text!, lastName: lastNameText.text!, favorite: 0, profilePic: "/images/missing.png", emailId: emailText.text!, phoneNumber: mobileText.text!)
                    viewModel.createNewContactDetail(detail: editContact)
                }
            }
        }
    }

    @IBAction func editImageMethod(_ sender: Any) {
        //New to integrated using uiimagepicker
        //Current passing missing png for new contact and update contact
    }
    
    //Update Data in UI
    fileprivate func refreshDisplay()
    {
        if let item = editContact
        {
            profilePic.imageFromServerURL(urlString: "http://gojek-contacts-app.herokuapp.com/\(item.profilePic)", defaultImage: "noImg")
            firstNameText.text = item.firstName
            lastNameText.text = item.lastName
            mobileText.text = item.phoneNumber
            emailText.text = item.emailId
        }
    }
}
extension GoJekAddEditViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension GoJekAddEditViewController: AddEditViewModelViewDelegate
{
    //Call back from view model for update UI
    func detailDidChange(viewModel: AddEditViewModel)
    {
        self.hideDataLoadingProgressHUD()
        guard navigationController?.popViewController(animated: true) != nil else { //modal
            dismiss(animated: true, completion: nil)
            return
        }
    }
}
