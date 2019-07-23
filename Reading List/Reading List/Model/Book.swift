//
//  Book.swift
//  Reading List
//
//  Created by Jeffrey Santana on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable {
	var title: String
	var reasonRead: String
	var isRead: Bool
	
	init(title: String, reason: String) {
		self.title = title
		self.reasonRead = reason
		isRead = false
	}
}
