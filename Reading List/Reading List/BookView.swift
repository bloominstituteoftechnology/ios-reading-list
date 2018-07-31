//
//  BookView.swift
//  Reading List
//
//  Created by William Bundy on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookCell: UITableViewCell
{

}

class BookListVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		return tableView.dequeueReusableCell(withIdentifier: "BookCell")!
	}
}

class AddBookVC: UIViewController
{

}
