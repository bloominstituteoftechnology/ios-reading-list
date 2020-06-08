//
//  BookTableViewDelegate.swift
//  Reading List
//
//  Created by Dojo on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
