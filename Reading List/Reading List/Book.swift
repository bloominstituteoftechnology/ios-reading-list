//
//  Book.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

struct Book: Equatable, Hashable, Codable {
	var title: String
	var reasonToRead: String
	var hasBeenRead: Bool
	let uuid: String //allows having "duplicates"
	var image: UIImage?

	init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
		self.title = title
		self.reasonToRead = reasonToRead
		self.hasBeenRead = hasBeenRead
		self.uuid = UUID().uuidString
	}
	
	static func == (lhs: Book, rhs: Book) -> Bool {
		return lhs.uuid == rhs.uuid
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(uuid)
	}
	
	enum CodingKeys: String, CodingKey {
		case title
		case reasonToRead
		case hasBeenRead
		case uuid
		case image
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(title, forKey: .title)
		try container.encode(reasonToRead, forKey: .reasonToRead)
		try container.encode(hasBeenRead, forKey: .hasBeenRead)
		try container.encode(uuid, forKey: .uuid)
		
		let imageData = NSKeyedArchiver.archivedData(withRootObject: image as Any)
		try container.encode(imageData, forKey: .image)

	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		title = try container.decode(String.self, forKey: .title)
		reasonToRead = try container.decode(String.self, forKey: .reasonToRead)
		hasBeenRead = try container.decode(Bool.self, forKey: .hasBeenRead)
		uuid = try container.decode(String.self, forKey: .uuid)
		
		if let imageData = try? container.decode(Data.self, forKey: .image) {
			image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
		}
	}
}
