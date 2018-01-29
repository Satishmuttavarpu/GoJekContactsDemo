//
//  AddEditViewModel.swift
//  GoJekContact
//
//  Created by muttavarapu on 29/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation
protocol AddEditViewModelViewDelegate: class
{
    func detailDidChange(viewModel: AddEditViewModel)
}

protocol AddEditViewModel
{
    var expectedContact: ContactItem? { get }
}
