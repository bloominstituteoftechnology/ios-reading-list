//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_241 on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore(){
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
            
        } catch {
            print("Error saving stars data: \(error)")
        }
        
        
    }
    
    func loadFromPersistentStore() {
            let fileManager = FileManager.default
        
        do {
            guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            
            books = decodedBooks
            

            } catch {
               print("error loading stars data: \(error)")
            }
        }
    
    @discardableResult func createBook(named name: String, reason reasonToRead: String) -> Book {
    let book = Book(title: name, reasonToRead: reasonToRead)
    books.append(book)
    saveToPersistentStore()
    return book
        
    }
    
    func deleteBook(_ book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
        }
        
        
    }
    
    
    // part 1, 6-update functions



}
