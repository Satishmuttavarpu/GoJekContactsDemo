//
//  ListViewModel.swift
//  GoJekContact
//
//  Created by muttavarapu on 25/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation

protocol ListViewModelViewDelegate: class
{
    func itemsDidChange(viewModel: ListViewModel)
}

protocol ListViewModel
{
    var numberOfItems: Int { get }
    func itemAtIndex(_ index: Int) -> ContactItem?
}
