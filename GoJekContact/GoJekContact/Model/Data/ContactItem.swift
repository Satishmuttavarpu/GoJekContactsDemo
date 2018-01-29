//
//  ContactItem.swift
//  GoJekContact
//
//  Created by muttavarapu on 25/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation

protocol ContactDataItem
{
    var firstName: String { get }
    var id: Int { get }
    var lastName: String { get }
    var favorite: Int { get }
    var profilePic: String { get }
    var url: String { get }
    var phoneNumber: String { get }
    var emailId: String { get }
}

struct ContactItem: ContactDataItem
{
    var id: Int
    var firstName: String
    var lastName: String
    var favorite: Int
    var profilePic: String
    var url: String
    var emailId: String
    var phoneNumber: String
    
    
    init(id: Int,firstName: String,lastName: String,favorite: Int,profilePic: String,url: String)
    {
        self.firstName = firstName
        self.id = id
        self.favorite = favorite
        self.lastName = lastName
        self.profilePic = profilePic
        self.url = url
        self.emailId = ""
        self.phoneNumber = ""
    }
    
    init(id: Int,firstName: String,lastName: String,favorite: Int,profilePic: String,emailId: String,phoneNumber: String)
    {
        self.firstName = firstName
        self.id = id
        self.favorite = favorite
        self.lastName = lastName
        self.profilePic = profilePic
        self.emailId = emailId
        self.phoneNumber = phoneNumber
        self.url = ""

    }
}
