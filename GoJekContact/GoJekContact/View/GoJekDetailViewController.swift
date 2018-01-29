//
//  GoJekDetailViewController.swift
//  GoJekContact
//
//  Created by muttavarapu on 26/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit

class GoJekDetailViewController: UITableViewController {

    @IBOutlet weak var detailEmail: UILabel!
    @IBOutlet weak var detailPhoneNumber: UILabel!
    @IBOutlet weak var detailFavButton: UIButton!
    @IBOutlet weak var DetailTitle: UILabel!
    @IBOutlet weak var DetailProfileImg: UIImageView!
    
    // View Controller's local variables
    private let viewModel = GoJekDetailViewModel()
    
    // Create a MessageComposer
    let messageComposer = MessageComposer()
    
    // Create a MailComposer
    let mailComposer = MailComposer()
    
    var contactUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize NavBar
        customizeNavBar()
        //Making Profile Pic in Circular
        DetailProfileImg.layer.cornerRadius = DetailProfileImg.frame.size.width/2
        DetailProfileImg.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Checking url is there are not..If there then passing to viewModel for fetch contact details
        if  let url = contactUrl {
            viewModel.viewDelegate = self
            self.showDataLoadingProgressHUD()
            viewModel.getContactDetailFromServer(detailPath: url)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeNavBar() {
        //Create Right Bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GoJekDetailViewController.editItemTapped(_:)))
        self.navigationController?.navigationBar.tintColor = UIColor.green

    }
    
    @objc func editItemTapped(_ sender:UIBarButtonItem!)
    {
        let addView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoJekAddEditViewController") as! GoJekAddEditViewController
        addView.isEdit = true
        addView.editContact = viewModel.expectedContact
        self.navigationController?.pushViewController(addView, animated: true)
    }
    
    
    //Update Data in UI
    fileprivate func refreshDisplay()
    {
        if let item = viewModel.expectedContact
        {
            DetailProfileImg.imageFromServerURL(urlString: "http://gojek-contacts-app.herokuapp.com/\(item.profilePic)", defaultImage: "noImg")
            DetailTitle.text = item.firstName
            detailPhoneNumber.text = item.phoneNumber
            detailEmail.text = item.emailId
            if item.favorite == 1
            {
                detailFavButton.setImage(UIImage(named: "fav")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }else{
                detailFavButton.setImage(UIImage(named: "unfav")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    // MARK: - Private Button Action Methods
    @IBAction func addFavMethod(_ sender: Any) {
        
        if let item = viewModel.expectedContact
        {
            self.showDataLoadingProgressHUD()
            if item.favorite == 1
            {
                detailFavButton.setImage(UIImage(named: "unfav")?.withRenderingMode(.alwaysOriginal), for: .normal)
                viewModel.updateFavorite(isFav: 0)
            }else{
                detailFavButton.setImage(UIImage(named: "fav")?.withRenderingMode(.alwaysOriginal), for: .normal)
                viewModel.updateFavorite(isFav: 1)

            }
        }
    }
    
    @IBAction func sendEmailMethod(_ sender: Any) {
        if let email = viewModel.expectedContact?.emailId
        {
            if email.count>1
            {
                // Make sure the device can send text messages
                if (mailComposer.canSendText()) {
                    // Obtain a configured MFMessageComposeViewController
                    let mailComposeVC = mailComposer.configuredMessageComposeViewController()
                    mailComposeVC.setToRecipients([email])
                    mailComposeVC.setMessageBody("Sending Mail through Email in GoJek", isHTML: false)
                    // Present the configured MFMessageComposeViewController instance
                    present(mailComposeVC, animated: true, completion: nil)
                } else {
                    // Let the user know if his/her device isn't able to send text messages
                    print("Your device is not able to send text messages.")
                }
            }
            
        }
    }
    
    @IBAction func makeCallMethod(_ sender: Any) {
        if let num = viewModel.expectedContact?.phoneNumber
            {
                if num.count>1
                {
                    if let url = URL(string: "tel://\(num)"), UIApplication.shared.canOpenURL(url)
                    {
                        if #available(iOS 10, *){
                            UIApplication.shared.open(url)
                        } else{
                            UIApplication.shared.openURL(url)
                        }
                    }
                }
            }
    }
    
    @IBAction func SendMessageMethod(_ sender: Any) {
        if let num = viewModel.expectedContact?.phoneNumber
        {
            if num.count>1
            {
                // Make sure the device can send text messages
                if (messageComposer.canSendText()) {
                    // Obtain a configured MFMessageComposeViewController
                    let messageComposeVC = messageComposer.configuredMessageComposeViewController()
                    messageComposeVC.recipients = [num]
                    // Present the configured MFMessageComposeViewController instance
                    present(messageComposeVC, animated: true, completion: nil)
                } else {
                    // Let the user know if his/her device isn't able to send text messages
                    print("Your device is not able to send text messages.")
                }
            }
            
        }
    }
}

extension GoJekDetailViewController: DetailViewModelViewDelegate
{
    //Call back from view model for update UI
    func detailDidChange(viewModel: DetailViewModel)
    {
        self.hideDataLoadingProgressHUD()
         refreshDisplay()
    }
}
