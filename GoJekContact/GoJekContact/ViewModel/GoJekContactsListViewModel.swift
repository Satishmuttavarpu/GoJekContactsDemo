//
//  GoJekContactsListViewModel.swift
//  GoJekContact
//
//  Created by muttavarapu on 25/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit

class GoJekContactsListViewModel: ListViewModel {
    
    weak var viewDelegate: ListViewModelViewDelegate?
    weak var coordinatorDelegate: ListViewModelCoordinatorDelegate?
    
    fileprivate var items: [ContactItem]?
    
    var numberOfItems: Int {
        if let items = items {
            return items.count
        }
        return 0
    }
    
    func itemAtIndex(_ index: Int) -> ContactItem?
    {
        if let items = items , items.count > index {
            return items[index]
        }
        return nil
    }
    
    func getContactListFromServer() {
        GoJekServiceManager.shared.fetchContactList { (response, error) in
            if let error = error {
                print ("Error while fetching data \(error)")
            }
            else {
                if let contactsArray=response{
                    self.items = [ContactItem]()
                    for dict in contactsArray
                    {
                        let item = dict as! Dictionary<String, Any>
                        let contactItem = ContactItem(id: item["id"] as! Int, firstName: item["first_name"] as! String, lastName: item["last_name"] as! String, favorite: item["favorite"] as! Int, profilePic: item["profile_pic"] as! String, url: item["url"] as! String)
                        self.items?.append(contactItem)
                    }
                    self.viewDelegate?.itemsDidChange(viewModel: self)
                }
            }
            
        }
        
    }
}

