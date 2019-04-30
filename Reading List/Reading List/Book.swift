//
//  Book.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Hashable, Codable {
	var title: String
	var reasonToRead: String
	var hasBeenRead: Bool
	let uuid: String = UUID().uuidString //allows having "duplicates"

	init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
		self.title = title
		self.reasonToRead = reasonToRead
		self.hasBeenRead = hasBeenRead
	}
}
