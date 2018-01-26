//
//  ViewControllerExtension.swift
//  GoJekContact
//
//  Created by muttavarapu on 26/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    func showDataLoadingProgressHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideDataLoadingProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
}
