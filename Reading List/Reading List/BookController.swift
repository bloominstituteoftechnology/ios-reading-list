//
//  BookController.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
	private(set) var books = [Book]()
	
	private var readingListURL: URL? {
		let fm = FileManager.default
		guard let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return documents.appendingPathComponent("ReadingList.plist")
	}
	
	
	func saveToPersistentStore() {
		guard let filePath = readingListURL else {
			print("couldn't get reading list url")
			return
		}
		let encoder = PropertyListEncoder()
		encoder.outputFormat = .openStep
		do {
			let booksData = try encoder.encode(books)
			try booksData.write(to: filePath)
		} catch {
			print("caught error saving data: \(error)")
		}
	}
	
	func loadFromPersistentStore() {
		guard let readingListURL = readingListURL else { return }
		do {
			let data = try Data(contentsOf: readingListURL)
			let decoder = PropertyListDecoder()
			let decodedBooks = try decoder.decode([Book].self, from: data)
			books = decodedBooks
		} catch {
			print("Caught error loading data: \(error)")
		}
	}
}
