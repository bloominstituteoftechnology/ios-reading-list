//
//  BookViewController.swift
//  Reading List
//
//  Created by Alex Thompson on 10/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()

        }
    }
    
    var books: [Book] = []
    
    private var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
    
    return documents.appendingPathComponent("ReadingList.plist")
    
    }
    
    func createNewBook(titled title: String, reasonsToRead reasonToRead: String, hasItBeenRead hasItBeenRead: Bool = false) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        
        books.append(book)
        saveToPersistentStore()
        
        return book
    }
    
    func removeBook(title: Book) {
        if let index = books.index(of: title) {
            books.remove(at: index)
            
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        var myBookHasBeenRead: Bool
        
        if book.hasBeenRead == false {
            myBookHasBeenRead = false
        } else {
            myBookHasBeenRead = true
        }
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Errot saving book: \(error)")
        }
    }

func loadFromPersistentStore() {
    guard let url = readingListURL else {return}
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        books = try decoder.decode([Book].self, from: data)
    } catch {
        print("Error loading book data: \(error)")
    }
}


