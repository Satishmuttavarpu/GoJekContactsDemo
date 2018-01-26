//
//  MessageComposer.swift
//  GoJekContact
//
//  Created by muttavarapu on 27/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    var recipents: [String]?
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        if let rec = self.recipents
        {
            messageComposeVC.recipients = rec
        }
        messageComposeVC.body =  "Sending Text Message through SMS in GoJek"
        return messageComposeVC
    }
    
    // MARK: -  MFMessageComposeViewControllerDelegate callback
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
