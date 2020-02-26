//
//  BookTableViewDelegate.swift
//  Reading List
//
//  Created by Bradley Diroff on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
