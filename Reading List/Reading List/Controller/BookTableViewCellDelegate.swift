//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Elizabeth Thomas on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

protocol BookTableViewCellDelegate: UITableViewDelegate {
    func toggleHasBeenAdded(for cell: BookTableViewCell)
}
