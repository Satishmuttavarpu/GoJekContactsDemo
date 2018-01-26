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
}

struct ContactItem: ContactDataItem
{
    let id: Int
    let firstName: String
    let lastName: String
    let favorite: Int
    let profilePic: String
    let url: String

    init(id: Int,firstName: String,lastName: String,favorite: Int,profilePic: String,url: String)
    {
        self.firstName = firstName
        self.id = id
        self.favorite = favorite
        self.lastName = lastName
        self.profilePic = profilePic
        self.url = url

    }
}
