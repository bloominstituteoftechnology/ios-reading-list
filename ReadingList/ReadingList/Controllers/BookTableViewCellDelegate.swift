//
//  BookTableViewCellDelegate.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
