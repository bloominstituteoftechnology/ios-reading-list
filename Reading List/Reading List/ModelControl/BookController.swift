//
//  BookController.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    var readingListURL: URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let listURL = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return listURL
    }
    
    init() {
        // FIXME: - what goes here?
    }
    
    // MARK: - SAVE
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let bookData = try encoder.encode(books)
            guard let listURL = readingListURL else { return }
            try bookData.write(to: listURL)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
}

//Create a function called saveToPersistentStore(). This function will be responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application. You can implement this by doing the following:
//
//Inside of a do-try-catch block create a constant called booksData. Using the encode(value: ...) function of the property list encoder, encode the books array into Data.
//Call the write(to: URL) function on the data you encoded computed property. The url you pass in should be an unwrapped version of the readingListURL property.
//Create a function called loadFromPersistentStore(). This function will be responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc. To implement this:
//
//Inside of a do-try-catch- block, unwrap the readingListURL property.
//Still inside of the block, use the Data(contentsOf: URL) initializer to get access to the property list form of the books. Assign this data you initialize to a constant.
//Initialize a PropertyListDecoder and assign it to a constant.
//Create a constant called decodedBooks. Set its value by calling the decode method on the property list decoder you just created, and passing in the type it should be decoded as, and the data constant you made a couple steps ago. (Hint: the type parameter to this function should be [Book].self)
//Set the value of the books property in the BookController to the decodedBooks you just made.
//In the catch block, you should make an error message that is descriptive of what happened
//Like always, we will need to make CRUD methods. As we're using a form of persistence, be sure to call saveToPersistentStore() at the end of each of these or the changes will not persist:
//
//Add a "Create" method that initializes a new Book object. In order to persist the newly created Book, call the saveToPersistentStore() method at the end of this function.
//Add a "Delete" method that passes in a Book object as a parameter, and removes it from the books array.
//We'll need two "Update" methods:
//One is to update a Book object's hasBeenRead property. Call it updateHasBeenRead(for book: Book). It should simply swap the hasBeenRead value from false to true and vice-versa.
//The other is to edit the Book's title and/or reasonToRead properties.
//You may have noticed from the screen recording that the table view is going to have more than one section. In order to facilitate the implementation of this multi-section table view, we're going to add a couple computed properties to the BookController:
//
//Create a computed property called readBooks: [Book]. Inside of the closure of the computed property, you will need to return an array of all of the Book objects from the books array whose hasBeenRead property is true. The easiest way to do that is by using the .filter higher-order function. If you are unfamiliar with this function, read the part of this article titled "Filter". If you still have questions, please ask in the help channel for your cohort, and a PM will explain it to you in more depth.
//Create a similar computed property called unreadBooks: [Book] that does the same thing, except it returns an array of Books whose hasBeenRead property is false.
