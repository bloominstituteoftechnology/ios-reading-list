//
//  BookController.swift
//  Reading List
//
//  Created by Taylor Lyles on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
	
	var books: [Book] = []
	
	var readingListURL: URL? {
		let fileManager = FileManager.default
		guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return nil
		}
		print("Documents: \(documents.path)")
		return documents.appendingPathComponent("ReadingList.plist")
	}
	
	func saveToPersistentStore() {
		guard let url = readingListURL else { return }
		
		let encoder = PropertyListEncoder()
		
		do {
			let booksData = try encoder.encode(books)
			try booksData.write(to: url)
		} catch {
			print("Error saving books: \(error)")
		}
		
	}
	
	func loadFromPersistentStore() {
		do {
			guard let url = readingListURL else { return }
			let data = try Data(contentsOf: url)
			let decodedBooks = PropertyListDecoder()
			books = try decodedBooks.decode([Book].self, from: data)
		} catch {
			print("Error loading data from disk: \(error)")
		}
	}
	
	func create(title: String, reasonToRead: String, hasBeenRead: Bool) {
		let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
		books.append(book)
		saveToPersistentStore()
	}
	
	
	func delete(book: Book) {
		guard let index = books.firstIndex(of: book) else { return }
		books.remove(at: index)
		saveToPersistentStore()
	}
	
	func updateHasBeenRead(for book: Book) {
		guard let index = books.firstIndex(of: book) else { return }
		books[index].hasBeenRead = !books[index].hasBeenRead
		saveToPersistentStore()
	}
	
	func updatedTitleAndOrReasonToRead(book: Book, title: String, reasonToRead: String) {
		guard let index = books.firstIndex(of: book) else { return }
		if (books[index].title != title) || (books[index].reasonToRead != reasonToRead) {
			books[index].title = title
			books[index].reasonToRead = reasonToRead
		}
		
	}
	
	var readBooks: [Book] {
		let beenRead = books.filter { $0.hasBeenRead == true }
		return beenRead
	}
	
	var unReadBooks: [Book] {
		let notBeenRead = books.filter { $0.hasBeenRead == false }
		return notBeenRead
	}
	
	
	
}
