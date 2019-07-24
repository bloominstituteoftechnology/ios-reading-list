//
//  BookController.swift
//  Reading List
//
//  Created by Jeffrey Santana on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
	private(set) var allBooks = [Book]()
	var filteredBooks: [(category: String, books: [Book])] {
		let readBooks = allBooks.filter{$0.isRead}.sorted { (book1, book2) -> Bool in
			book1.title < book2.title
		}
		let unreadBooks = allBooks.filter{!$0.isRead}.sorted { (book1, book2) -> Bool in
			book1.title < book2.title
		}
		var books = [(category: String, books: [Book])]()
		
		if !readBooks.isEmpty {
			books.append((category: "Read", books: readBooks))
		}
		if !unreadBooks.isEmpty {
			books.append((category: "Unread", books: unreadBooks))
		}
		
		return books
	}
	
	init() {
		loadFromPersistenStore()
	}
	
	func createBook(title: String, reason: String) {
		let latestIndex = allBooks.count + 1
		let newBook = Book(index: latestIndex, title: title, reason: reason)
		allBooks.append(newBook)
		saveToPersistentStore()
	}
	
	func toggleReadStatus(for book: Book) {
		guard let index = allBooks.firstIndex(where: {$0.index == book.index}) else { return }
		allBooks[index].isRead.toggle()
	}
	
	//MARK: - Persistence
	
	func saveToPersistentStore() {
		guard let url = persistentFileURL else { return }
		
		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(allBooks)
			try data.write(to: url)
		} catch {
			print("Error saving books data: \(error.localizedDescription)")
		}
	}
	
	func loadFromPersistenStore() {
		let fm = FileManager.default
		guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			allBooks = try decoder.decode([Book].self, from: data)
		} catch {
			print("Error loading books data: \(error.localizedDescription)")
		}
	}
	
	//MARK: - Private
	
	private var persistentFileURL: URL? {
		let fm = FileManager.default
		guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		
		return dir.appendingPathComponent("books.plist")
	}
}
