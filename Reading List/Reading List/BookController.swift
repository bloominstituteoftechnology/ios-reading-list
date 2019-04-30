//
//  BookController.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
	
	
	
	
	
	
	
	
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
