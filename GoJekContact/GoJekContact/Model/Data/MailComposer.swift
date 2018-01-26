//
//  MailComposer.swift
//  GoJekContact
//
//  Created by muttavarapu on 27/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit
import MessageUI

class MailComposer: NSObject, MFMailComposeViewControllerDelegate {
    
    // A wrapper function to indicate whether or not a emial can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        return mailComposeVC
    }
    // MARK: -  MFMailComposeViewControllerDelegate callback

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
