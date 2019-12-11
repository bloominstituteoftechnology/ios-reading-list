//
//  BookController.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

import UIKit

class BookController {
    
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    //private(set) var readBooks: [Book.filter.hasBeenRead = true] = [] //??????????????
    //
    //private var readingListURL: URL? {
    //    let FileManager = FileManager.default
    //    guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    //
    //    return documents.appendingPathComponent("ReadingList.plist")
    //}
    
    @discardableResult func createBook(titled title: String, withReasonToRead reasonToRead: String) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
        return book
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving book data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error saving book data: \(error)")
        }
    }
}

//protocol deleteBookDelegate {
//
//    func bookWasDeleted(_ book: Book)
//}
//
//class BooksViewController: UIViewController {
//
//
//
//    var book: Book?
//
//    var delegate: deleteBookDelegate?
//
//
//    @IBAction func deleteTapped(_ sender: UIBarButtonItem) {
//
//        let book = Book(bookName: bookName)
//
//        delegate?.bookWasDeleted(book)
//        dismiss(animated: true, completion: nil)
//    }
//    saveToPersistentStore()
//}
