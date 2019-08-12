//
//  SettingsDetailViewController.swift
//  Reading List
//
//  Created by Casualty on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

var backgroundColorWhite: UIColor = .white
var backgroundColorBlack: UIColor = .black
var textColorBlack: UIColor = .black
var textColorWhite: UIColor = .white

class SettingsDetailViewController: UIViewController {

    @IBOutlet weak var darkModeLabel: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButton.isOn =  UserDefaults.standard.bool(forKey: "switchState")
        if switchButton.isOn {
            view.backgroundColor = backgroundColorBlack
            darkModeLabel.textColor = textColorWhite
        } else {
            view.backgroundColor = backgroundColorWhite
            darkModeLabel.textColor = textColorBlack
        }

    }
    

    @IBAction func darkModeTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
        if view.backgroundColor == backgroundColorWhite {
            view.backgroundColor = backgroundColorBlack
            darkModeLabel.textColor = textColorWhite
            
        } else {
            view.backgroundColor = backgroundColorWhite
            darkModeLabel.textColor = textColorBlack
        }
        
    }
    
}


