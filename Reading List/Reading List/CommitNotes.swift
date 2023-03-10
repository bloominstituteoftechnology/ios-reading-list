//
//  CommitNotes.swift
//  Reading List
//
//  Created by Harm on 3/4/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import Foundation

/*
 
 // MARK: - WIP
 
 
 
 // MARK: - To do
 Part 1 Book and BookController
    BookController
        5. Create a function loadFromPersistentStore
            Inside a do-try-catch block, unwrap the readingListURL
            Inside the same block, use Data(contentsOf: URL) init to get access to property list form of the books and assign this data to a constant
            Initialize a PropertyListDecoder and assign it to a constant
            Create a constant decodedBooks and set value by calling the decode method on the decoder
            Set the value of books property in BookController to decodedBooks
            In the catch block, make an error message
        6. Make CRUD methods (call saveToPersistentStore() at the end of each)
            "Create" method that inits a new Book object
            "Delete" method that passes in a Book object as a parameter and removes it from books
            "Update" method "updateHasBeenRead(for book: Book)", change the hasBeenRead value
            "Update" method "updateReasonOrTitle(for books: Book)", swap old title/reason properties with new Strings
        7. "readBooks: [Book]" computed property that returns an array of all Book objects in books whose hasBeenRead property is true
        8. "unreadBooks: [Book]" computed property that returns an array of all Book objects in books whose hasBeenRead property is false
 Part 2 Storyboard Scenes
 Part 3 Wiring Everything Up
 
 // MARK: - Done
 Part 1 Book and BookController
    Book
        1. Create a "Book.swift" file
        2. Create a struct "Book" that has a title string, a reasonToRead string, and  hasBeenRead bool
        3. Create initializer for struct, default value of false to hasBeenRead
        4. Adopt Equatable and Codable protocols
    BookController
        1. Create a "BookController.swift" file
        2. Create a BookController class with the variable books set to an empty array of Book objects
        3. Create computed property called "readingListURL: URL?" and inside:
            Get user's document directory using FileManager class
            Create filename string for plist such as "ReadingList.plist"
            Return URL appending the filename string to the document directory
        4.Create a function saveToPersistentStore() and inside:
            Create an instance of PropertyListEncoder
            Inside a do-try-catch block, create a constant booksData
            Encode the books array into Data using encode(value: ...) function of the property list encoder, encode the books array into Data.
            Call the write(to: URL) function on the data you encoded computed property, URL passed in should be unwrapped version of readingListURL
 
*/
