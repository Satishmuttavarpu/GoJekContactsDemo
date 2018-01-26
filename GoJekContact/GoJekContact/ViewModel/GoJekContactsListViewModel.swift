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
    
    var sections : [(index: Int, length :Int, title: String)] = Array()
    
    //For return total number of contacts
    var numberOfItems: Int {
        if let items = items {
            return items.count
        }
        return 0
    }
    
    //For retrive contact based on index
    func itemAtIndex(_ index: Int) -> ContactItem?
    {
        if let items = items , items.count > index {
            return items[index]
        }
        return nil
    }
    
    //For fetching data from server
    func getContactListFromServer() {
        GoJekServiceManager.shared.fetchContactList { (response, error) in
            if let error = error {
                print ("Error while fetching data \(error)")
            }
            else {
                if let contactsArray=response{
                    var list = [ContactItem]()
                    //Mapping from serer data to model objects
                    for dict in contactsArray
                    {
                        let item = dict as! Dictionary<String, Any>
                        let contactItem = ContactItem(id: item["id"] as! Int, firstName: item["first_name"] as! String, lastName: item["last_name"] as! String, favorite: item["favorite"] as! Int, profilePic: item["profile_pic"] as! String, url: item["url"] as! String)
                        list.append(contactItem)
                    }
                    
                    //Sorting Response for display in Alphabet order
                    self.items = list.sorted(by: { (item1:ContactItem, item2:ContactItem) -> Bool in
                        return item1.firstName.lowercased().compare(item2.firstName.lowercased()) == ComparisonResult.orderedAscending
                    })
            
                    //prepare for section tittle and index in tableview
                    var index = 0;
                    for i in 0..<self.numberOfItems {
                        if let item = self.itemAtIndex(i)
                        {
                            if let someItem = self.itemAtIndex(index)
                            {
                                let commonPrefix = item.firstName.commonPrefix(with: someItem.firstName, options: .caseInsensitive)
                                
                                if commonPrefix.count == 0
                                {
                                    let string = someItem.firstName.uppercased();
                                    let firstCharacter = string[string.startIndex]
                                    let title = "\(firstCharacter)"
                                    let newSection = (index: index, length: i - index, title: title)
                                    self.sections.append(newSection)
                                    index = i;
                                }
                            }
                        }
                    }
                    //Call back to list viewcontroller for displaying contacts
                    self.viewDelegate?.itemsDidChange(viewModel: self)
                }
            }
        }        
    }
}

