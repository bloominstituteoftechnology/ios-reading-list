//
//  Book.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
	let title: String
	let reasonToRead: String
	let hasBeenRead: Bool

	init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
		self.title = title
		self.reasonToRead = reasonToRead
		self.hasBeenRead = hasBeenRead
	}
}
