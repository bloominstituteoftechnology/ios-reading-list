//
//  BookController.swift
//  ReadTheList Project
//
//  Created by Michael Flowers on 1/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class BookController {
    
    //MARK: - Properties
   private(set) var books = [Book]()
    
    //We need a place to save this property list on the devices' hard drive.
    var readingListURL: URL? {
        //get the user's document directory using FileManager class
        let fileManager = FileManager.default
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        //create a filename string for the plist
        let fileName = "ReadingList.plist"
        let finalLocation = documentDir.appendingPathComponent(fileName)
        
        //return url that appends the fileName string to the document directory.
        return finalLocation
    }
    
    var readBooks: [Book] {
        let didRead = books.filter({$0.hasBeenRead == true })
        return didRead
    }
    
    var unReadBooks: [Book] {
        let notRead = books.filter({$0.hasBeenRead == false })
        return notRead
    }
    
    init() {
        loadFromPersistenceStore()
    }
    
    //MARK: - CRUD Functions
    
    func createBook(with title: String, reasonToRead: String){
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistenceStore()
    }
    
    func delete(book: Book){
        //find index
        guard let index = books.firstIndex(of: book) else { return }
        
        //remove found index in array
        books.remove(at: index)
        saveToPersistenceStore()
    }
    
    func updateBook(book: Book, newTitle: String, newReasonToRead: String){
        book.title = newTitle
        book.reasonToRead = newReasonToRead
        saveToPersistenceStore()
    }
    
    func updateHasBeenRead(for book: Book, to hasBeenRead: Bool){
        book.hasBeenRead = hasBeenRead
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    
    func saveToPersistenceStore(){
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data =  try encoder.encode(books)
            try data.write(to: url)
        } catch  {
            print("Error writing to persistence storage: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistenceStore(){
          guard let url = readingListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch  {
            print("Error loading from persistence storage: \(error.localizedDescription)")
        }
    }
}
