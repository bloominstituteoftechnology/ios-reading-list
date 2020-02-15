//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Juan M Mariscal on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
    
}
