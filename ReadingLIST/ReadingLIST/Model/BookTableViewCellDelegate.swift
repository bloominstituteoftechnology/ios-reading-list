//
//  BookTableViewCellDelegate.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

protocol BookTableViewDelegate : AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}




