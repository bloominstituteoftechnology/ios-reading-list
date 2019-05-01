//
//  CheckButton.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class CheckButton: UIButton {

	private var _isChecked = false
	var isChecked: Bool {
		get {
			return _isChecked
		}
		set {
			_isChecked = newValue
			updateViews()
		}
	}
	
	func updateViews() {
		if isChecked {
			setImage(#imageLiteral(resourceName: "checked"), for: .normal)
		} else {
			setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
		}
	}

}
