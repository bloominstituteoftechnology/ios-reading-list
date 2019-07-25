//
//  Book.swift
//  Reading List
//
//  Created by Ry Bautista on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable {
	var index: Int
	var title: String
	var reasonRead: String
	var isRead = false
	
	init(index: Int, title: String, reason: String) {
		self.index = index
		self.title = title
		self.reasonRead = reason
		isRead = false
	}
}
