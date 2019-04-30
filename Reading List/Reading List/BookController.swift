//
//  BookController.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
	
	//guard let index = books.firstIndex(of: book) else { return }
	//
	
	private func getBookIndex(book: Book) -> Int? {
		guard let index = books.firstIndex(of: book) else {
			return nil
		}
		return index
	}
	
	func creatBook(title: String, reasonToRead: String){
		let book = Book(title: title, reasonToRead: reasonToRead)
		books.append(book)
	}
	
	
	func loadFromPersistentStore() {
		//make sure file exist
		let fileManager = FileManager.default
		guard let url = readingListURL,
			fileManager.fileExists(atPath: url.path) else {
				print("error: loadFromPersistentStore()")
				return
		}
		
		// load and decoode data
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			let decodedBooks = try decoder.decode([Book].self, from: data)
			books = decodedBooks
		}catch {
			NSLog("Error loading book data: \(error)")
		}
	}
	
	func saveToPersistentStore() {
		guard let url = readingListURL else { return }
		do {
			//Create an instance of PropertyListEncoder
			let encoder = PropertyListEncoder()
			//encode books data
			let data = try encoder.encode(books)
			//encode the books array into Data
			try data.write(to: url)
		} catch {
			NSLog("Error saving book data: \(error)")
		}
	}
	
	private var readingListURL: URL? {
		//Get the user's document directory using the FileManager class.
		let fileManager = FileManager.default
		guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		
		//Create a filename string for the plist, such as "ReadingList.plist"
		let fileName = "ReadingList.plist"
		
		//Return a url that appends the filename string to the document directory.
		let document = documents.appendingPathComponent(fileName)
		
		print(document)
		return document
	}
	
	private(set) var books: [Book] = []
}
