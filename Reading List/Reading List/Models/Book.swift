//
//  Book.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

struct Book: Equatable, Codable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.hasBeenRead == rhs.hasBeenRead && lhs.title == rhs.title && lhs.reasonToRead == rhs.reasonToRead
    }
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    var image: Image
    
    init (title: String, reasonToRead: String, hasBeenRead: Bool = false, image: Image) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
        self.image = image
    }
}

// MARK: - UIImage Codable

struct Image: Codable {
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = UIImagePNGRepresentation(image)
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else { return nil }
        let image = UIImage(data: imageData)
        
        return image
    }
    
}
