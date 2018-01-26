//
//  DetailViewModel.swift
//  GoJekContact
//
//  Created by muttavarapu on 26/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation

protocol DetailViewModelViewDelegate: class
{
    func detailDidChange(viewModel: DetailViewModel)
}

protocol DetailViewModel
{
    var expectedContact: ContactItem? { get }
}
