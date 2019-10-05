//
//  Book.swift
//  Reading List
//
//  Created by Karim Boudlal on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
struct book{
  var  title: String
   var reasonToRead: String
  var   hasBeenRead: Bool
    

  init(book: String?, title: String, reaonToRead: String, HasBeenRead: Bool)
    self.book = book
    self.title = title
    self.reasonToRead = reasonToRead
    self.hasBeenRead = hasbeenRead
    

}
