//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_201 on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    
    
    
    
    
    
//Mark: - Computed property:
    
    //Returning array of read books.
    var readBooks: [Book] {
        var readBooks = books.filter {$0.hasBeenRead == true}
        readBooks.sort {
            $0.title < $1.title
        }
        return readBooks
    }
        
     // Returning array of Unread books.
    var unReadBooks: [Book] {
        var unReadBooks = books.filter {$0.hasBeenRead == false}
        unReadBooks.sort {
            $0.title < $1.title
        }
        return unReadBooks
    }
    
    
    
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
        
    }
    
//Mark: - Part of CRUD:
    
    //CREATING new book and READING:
    
    func createNewBook(title: String, reasonToRead: String){
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        
    }
    
    //Editing an existing book.
    func editBook(for book: String, reasonToRead: String) {
        var editBook = book
        editBook = ""
        var editReason = reasonToRead
        editReason = ""
    }
    
        
    
//Mark: - DELETING Books method.
    func removeBook(title: Book) {
        if let index = books.index(of: title) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
            
    
    
//Mark: - UPDATING methods for hasBeenRead:
    
    func updatehasBeenRead(for book: Book) {
        guard let index = books.index(of: book)else {return}
        books[index].hasBeenRead.toggle()
        //books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
        
    }
        
    
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving book: \(error)")
        }
    }
    
    
    
    //Mark: - Check this code. ASking for decodeBooks as constant, and setting value by calling the decode Method.
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
}
    
    
    
    
    
    
    
    
