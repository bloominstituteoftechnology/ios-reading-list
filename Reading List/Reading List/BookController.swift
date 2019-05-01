//
//  BookController.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
	private(set) var books = MyOrderedSet<Book>()
	
	var readBooks: [Book] {
		return books.filter{ $0.hasBeenRead }
	}
	
	var unreadBooks: [Book] {
		return books.filter{ !$0.hasBeenRead }
	}
	
	private var readingListURL: URL? {
		let fm = FileManager.default
		guard let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return documents.appendingPathComponent("ReadingList.plist")
	}
	
	init() {
		loadFromPersistentStore()
	}
	
	func createBook(titled title: String, because reasonToRead: String) {
		books.append(Book(title: title, reasonToRead: reasonToRead))
		saveToPersistentStore()
	}
	
	func delete(book: Book) {
		books.remove(book)
		saveToPersistentStore()
	}
	
	func updateHasBeenRead(for book: Book) {
		guard let index = books.index(of: book) else { return }
		books[index].hasBeenRead.toggle()
		saveToPersistentStore()
	}
	
	func update(title: String? = nil, reasonToRead reason: String? = nil, forBook book: Book) {
		guard let index = books.index(of: book) else { return }
		if let title = title {
			books[index].title = title
		}
		if let reason = reason {
			books[index].reasonToRead = reason
		}
		saveToPersistentStore()
	}

	func saveToPersistentStore() {
		guard let filePath = readingListURL else {
			print("couldn't get reading list url")
			return
		}
		let encoder = PropertyListEncoder()
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
			let decodedBooks = try decoder.decode(MyOrderedSet<Book>.self, from: data)
			books = decodedBooks
		} catch {
			print("Caught error loading data: \(error)")
		}
	}
}


protocol BookControllerProtocol {
	var bookController: BookController? {get set}
}
