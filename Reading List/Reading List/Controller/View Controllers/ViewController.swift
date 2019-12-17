//
//  ViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let librarian = BookController()
        
        
        
        //MARK: Dev/Testing
        //librarian.testSave()
        librarian.loadFromPersistentStore()
        //librarian.testDelete()
        //librarian.testHasBeenRead()
        librarian.testUpdateBook()
        print(librarian.books)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

