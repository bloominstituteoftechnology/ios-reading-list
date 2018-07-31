//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)


        return cell
    }
    
    @IBAction func toggleBookReadStatus(_ sender: Any) {
    }
    
    // MARK: - Properties
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookHasBeenRead: UIButton!
    
}
