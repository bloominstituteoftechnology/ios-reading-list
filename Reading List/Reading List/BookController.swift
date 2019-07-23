//
//  BookController.swift
//  Reading List
//
//  Created by Taylor Lyles on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
	
	private(set) var books = [Book]()
	
	func create(withTitle title: String, reasonToBeRead: String, hasBeenRead: Bool) {
		let book = Book(title: title, reasonToRead: reasonToBeRead, hasBeenRead: hasBeenRead)
		books.append(book)
		saveToPersistentStore()
	}
	
	func delete(book: Book) {
		guard let index = books.firstIndex(of: book) else { return }
		books.remove(at: index)
		saveToPersistentStore()
	}
	
	func hasBeenRead(for book: Book) {
		guard let index = books.firstIndex(of: book) else { return }
		books[index].hasBeenRead = !books[index].hasBeenRead
		saveToPersistentStore()
	}
	
	func titleAndReasonToRead(book: Book, title: String, reasonToRead: String) {
		guard let index = books.firstIndex(of: book) else { return }
		if (books[index].title != title) || (books[index].reasonToRead != reasonToRead) {
			books[index].title = title
			books[index].reasonToRead = reasonToRead
		}
	}
	
	// MARK: - Persistence
	
	func saveToPersistentStore() {
		guard let url = readingListURL else { return }
		
		do {
			let encoder = PropertyListEncoder()
			let booksData = try encoder.encode(books)
			try booksData.write(to: url)
		} catch {
			print("Error saving books data: \(error)")		}
	}
	
	func loadToPersistentStore() {
		let fm = FileManager.default
		guard let url = readingListURL,
			fm.fileExists(atPath: url.path) else { return }
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			books = try decoder.decode([Book].self, from: data)
		} catch {
			print("Error loading books data: \(error)")
		}
	}
	
	// MARK: - Private
	
	private var readingListURL: URL? {
		let fm = FileManager.default
		guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return dir.appendingPathComponent("books.plist")
	}
	
}
