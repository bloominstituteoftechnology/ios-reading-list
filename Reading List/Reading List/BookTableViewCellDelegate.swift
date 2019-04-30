//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

//delegation
protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
