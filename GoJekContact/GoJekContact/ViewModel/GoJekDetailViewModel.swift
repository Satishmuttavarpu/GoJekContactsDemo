//
//  GoJekDetailViewModel.swift
//  GoJekContact
//
//  Created by muttavarapu on 26/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation
import UIKit

class GoJekDetailViewModel:DetailViewModel {
    weak var viewDelegate: DetailViewModelViewDelegate?

   fileprivate(set) var expectedContact: ContactItem?
    {
        didSet {
        }
    }

    //For fetching data from server
    func getContactDetailFromServer(detailPath:String?) {
        if let url = detailPath
        {
            GoJekServiceManager.shared.fetchContactDetail(path: URL(string: url), completion: { (response, error) in
                if let error = error {
                    print ("Error while fetching data \(error)")
                }
                else {
                    if let item=response{
                        self.expectedContact = ContactItem(id: item["id"] as! Int, firstName: item["first_name"] as! String, lastName: item["last_name"] as! String, favorite: item["favorite"] as! Int, profilePic: item["profile_pic"] as! String, emailId: item["email"] as! String, phoneNumber: item["phone_number"] as! String)
                        self.viewDelegate?.detailDidChange(viewModel: self)

                    }
                }
            })
        }
    }
    
    //For update favorite data in server
    func updateFavorite(isFav:Int?) {
        if let val = isFav
        {
            self.expectedContact?.favorite = val
            GoJekServiceManager.shared.updateContactDetail(contactItem: self.expectedContact, completion: { (response, error) in
                if let error = error {
                    print ("Error while fetching data \(error)")
                }
                else {
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
}
