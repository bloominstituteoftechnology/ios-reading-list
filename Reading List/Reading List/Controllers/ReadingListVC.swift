//
//  ReadingListVC.swift
//  Reading List
//
//  Created by Jeffrey Santana on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	let bookController = BookController()
	
	override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReadingListVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return bookController.filteredBooks.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return bookController.filteredBooks[section].category
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return bookController.filteredBooks[section].books.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookCell else { return UITableViewCell() }
		let books = bookController.filteredBooks[indexPath.section].books
		let book = books[indexPath.row]
		
		cell.book = book
		return cell
	}
}
