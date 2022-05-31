//
//  CodableImage.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/29/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import Foundation
import UIKit

struct CodableImage: Codable {
    
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }
    
    func getImage() -> UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
    
}
