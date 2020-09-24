//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by John McCants on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
