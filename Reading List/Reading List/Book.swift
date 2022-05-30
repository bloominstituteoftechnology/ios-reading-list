//
//  Book.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/19/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable, Comparable {
    
//MARK: - Properties
    var title:        String
    var reasonToRead: String
    var hasBeenRead:  Bool
    var image: CodableImage?
    
//MARK: - Methods
    // Init
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
    // Comparable protocol conformance
    static func < (lhs: Book, rhs: Book) -> Bool {
        var bookArray = [lhs.title, rhs.title]
        bookArray.sort()
        return lhs.title == bookArray.first
    }
    //Equatable protocol conformance
    static func == (lhs: Book, rhs: Book) -> Bool {
        let leftImage = lhs.image?.getImage()
        let rightImage = rhs.image?.getImage()
        let result =
        lhs.title == rhs.title &&
        lhs.reasonToRead == rhs.reasonToRead &&
        lhs.hasBeenRead == rhs.hasBeenRead &&
        leftImage?.isEqual(rightImage) == true
        return result
    }
    
}
