//
//  BookController.swift
//  Reading List
//
//  Created by Percy Ngan on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {

	var books: [Book] = []


	// Getting documents URL and appending ReadingList.plist to dir
	private var readingListURL: URL? {
		let fm = FileManager.default
		guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask) .first else { return nil }
		return dir.appendingPathComponent("ReadingList.plist")
	}


	// Return all books that have been read
	var readBooks: [Book] {
		return books.filter{ $0.hasBeenRead }
	}

	// Return all books that have not been read
	var unreadBooks: [Book] {
		return books.filter{ !$0.hasBeenRead}
	}


	// Encoding books array to PropertyList and saving it to readingListURL
	private func saveToPersistentStore() {
		guard let url = readingListURL else { return }

		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(books)
			try data.write(to: url)
		} catch {
			NSLog("Error saving stars data: \(error)")
		}
	}


	// Decode data at path readingListURL and update books array
	private func loadFromPersistentStore() {
		let filemanager = FileManager.default
		guard let url = readingListURL, filemanager.fileExists(atPath: url.path) else { return }

		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			let decodedBooks = try decoder.decode([Book].self, from: data)
			books = decodedBooks
		} catch {
			NSLog("Error loading books data: \(error)")
		}
	}


	func createABook(name: String, reason reasonToRead: String) -> Book {
		let book = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: false)
		books.append(book)
		saveToPersistentStore()
		return book
	}

	func deleteABook(book: Book) {
		guard let index = books.firstIndex(of: book) else { return }
		books.remove(at: index)
		saveToPersistentStore()
	}

	func updateHasBeenRead(for book: Book) {
		guard let index = books.index(of: book) else { return }
		books[index].hasBeenRead.toggle()
	}

	func updateBook(title: String?, reasonToRead reason: String?, book: Book) {
		guard let index = books.index(of: book) else { return }
		if let title = title {
			books[index].title = title
		}
		if let reason = reason {
			books[index].reasonToRead = reason
		}
		saveToPersistentStore()
	}






}
