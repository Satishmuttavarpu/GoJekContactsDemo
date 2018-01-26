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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Initial load of data
        fetchContactList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private Methods
    func fetchContactList() {
        viewModel.viewDelegate = self
        viewModel.getContactListFromServer()
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
    func itemsDidChange(viewModel: ListViewModel)
    {
        tableView.reloadData()
    }
}
