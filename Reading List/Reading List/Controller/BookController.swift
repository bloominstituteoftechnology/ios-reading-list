//
//  BookController.swift
//  Reading List
//
//  Created by Chad Parker on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []

    var readingListURL: URL? {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("ReadingList.plist")
    }

    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let booksData = try PropertyListEncoder().encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }

    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            books = try PropertyListDecoder().decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
