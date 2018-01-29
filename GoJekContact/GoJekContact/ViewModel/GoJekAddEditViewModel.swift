//
//  GoJekAddEditViewModel.swift
//  GoJekContact
//
//  Created by muttavarapu on 29/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation
import UIKit

class GoJekAddEditViewModel: AddEditViewModel {
    weak var viewDelegate: AddEditViewModelViewDelegate?
    fileprivate(set) var expectedContact: ContactItem?
    {
        didSet {
        }
    }
    
    //For Update contact detail in server
    func updatedContactDetailToServer(detail:ContactItem?)
    {
        GoJekServiceManager.shared.updateContactDetail(contactItem: detail, completion: { (response, error) in
            if let error = error {
                print ("Error while fetching data \(error)")
            }
            else {
                guard (response?.keys.contains("errors"))! == false else
                {
                    return
                }
                //For refresh data in Home screen
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.isChange = true
                    if let item=response{
                        self.expectedContact = ContactItem(id: item["id"] as! Int, firstName: item["first_name"] as! String, lastName: item["last_name"] as! String, favorite: item["favorite"] as! Int, profilePic: item["profile_pic"] as! String, emailId: item["email"] as! String, phoneNumber: item["phone_number"] as! String)
                        self.viewDelegate?.detailDidChange(viewModel: self)
                    }
            }
        })
    }
    
    //For creating new contact detail in server and updated in UI
    func createNewContactDetail(detail:ContactItem?)
    {
        GoJekServiceManager.shared.newContactDetail(contactItem: detail, completion: { (response, error) in
            if let error = error {
                print ("Error while fetching data \(error)")
            }
            else {
                
                guard (response?.keys.contains("errors"))! == false else
                {
                    return
                }
                //For refresh data in Home screen
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.isChange = true
                
                if let item=response{
                    self.expectedContact = ContactItem(id: item["id"] as! Int, firstName: item["first_name"] as! String, lastName: item["last_name"] as! String, favorite: item["favorite"] as! Int, profilePic: item["profile_pic"] as! String, emailId: item["email"] as! String, phoneNumber: item["phone_number"] as! String)
                    self.viewDelegate?.detailDidChange(viewModel: self)
                }
            }
            
        })
    }
    
    
}
