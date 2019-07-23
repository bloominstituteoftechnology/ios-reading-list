//
//  BookController.swift
//  Reading List
//
//  Created by Bradley Yin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books = [Book]()
    
    var readingListURL: URL?{
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return dir.appendingPathComponent("ReadingList.plist")
    }
    var readBooks : [Book]{
        return books.filter{$0.hasBeenRead == true}
    }
    var unreadBooks : [Book]{
        return books.filter{$0.hasBeenRead == false}
    }
    
    func saveToPersistentStore(){
        guard let url = readingListURL else{return}
        let encoder = PropertyListEncoder()
        do{
           let data = try encoder.encode(books)
            try data.write(to: url)
        }catch{
            print("Error saving data: \(error)")
        }
    }
    
    func loadFromPersistentStore(){
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else {return}
        do{
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        }catch{
            print("Error loading data: \(error)")
        }
    }
    func createNewBook(name: String, reasonToRead: String){
        let book = Book(name: name, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteABook(book: Book){
        books.removeAll(where: {$0 == book})
        saveToPersistentStore()
    }
    func updateHasBeenRead(for book: Book){
        if let index = books.index(where:{$0 == book}){
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    }
    func updateNameOrReason(name: String?, reason: String?, book: Book){
        if let index = books.index(where:{$0 == book}){
            if let name = name{
                books[index].name = name
            }
            if let reason = reason{
                books[index].reasonToRead = reason
            }
            saveToPersistentStore()
            
        }
    }

}
