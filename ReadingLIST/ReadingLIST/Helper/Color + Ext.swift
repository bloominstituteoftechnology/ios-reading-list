//
//  Color + Ext.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 7/16/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}


extension UIColor {
  static func random() -> UIColor {
    return UIColor(red:   .random(),
                   green: .random(),
                   blue:  .random(),
                   alpha: 1.0)
  }
}
