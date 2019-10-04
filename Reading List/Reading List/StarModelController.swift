//
//  StarModelController.swift
//  Reading List
//
//  Created by Christy Hicks on 10/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class StarController {
    private(set) var stars: [Star] = []
    // var starA = [Star]()  // (Alternate method to call this)
    // starB: [Star] = [Star]() // (Alternate method to call this)
    
    func createStar(named name: String, withDistance distance: Double) {
        let star = Star(name: name, distanceInLightYears: distance)
        
        stars.append(star)
    }
}
