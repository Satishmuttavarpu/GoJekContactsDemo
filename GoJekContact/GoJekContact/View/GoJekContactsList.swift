//
//  GoJekContactsList.swift
//  GoJekContact
//
//  Created by muttavarapu on 25/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import UIKit

class GoJekContactsList: UITableViewController {

    // View Controller's local variables
    private let viewModel = GoJekContactsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Customize NavBar
        customizeNavBar()
        // Initial load of data
        fetchContactList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.isChange{
            appDelegate.isChange = false
            // Refresh updated data
            fetchContactList()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private Methods
    func fetchContactList() {
        viewModel.viewDelegate = self
        self.showDataLoadingProgressHUD()
        viewModel.getContactListFromServer()
    }
    
    func customizeNavBar() {
        //Create Right Bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactMethod))
        //Create Left Bar Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Groups", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.green
        navigationItem.title = "Contacts"
    }
    
    @objc func addContactMethod() {
        
        let addView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoJekAddEditViewController") as! GoJekAddEditViewController
        addView.isEdit = false
        self.navigationController?.pushViewController(addView, animated: true)
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.sections.count>0 {
            return viewModel.sections.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.sections[section].length>0 {
            return viewModel.sections[section].length
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! GoJekCustomCell
        cell.item=viewModel.itemAtIndex(viewModel.sections[indexPath.section].index + indexPath.row)
        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel.itemAtIndex(viewModel.sections[indexPath.section].index + indexPath.row)
        {
            let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoJekDetailViewController") as! GoJekDetailViewController
            detailView.contactUrl = item.url;
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    // MARK: - Table View Title for Header In Section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
    
    // MARK: - Table view Index Title
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sections.map { $0.title }
    }
}

extension GoJekContactsList: ListViewModelViewDelegate
{
    //Call back from view model for update UI
    func itemsDidChange(viewModel: ListViewModel)
    {
        self.hideDataLoadingProgressHUD()
        tableView.reloadData()
    }
}
