//
//  dateExtension.swift
//  GoJekContact
//
//  Created by muttavarapu on 26/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation

extension Date
{
    
    func GoJekstringFromDate() -> String{
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let strdt = dateFormatter.string(from: self as Date)
        if let dtDate = dateFormatter.date(from: strdt){
            return dateFormatter.string(from: dtDate)
        }
        return "--"
    }
}
