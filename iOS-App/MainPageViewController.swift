//
//  MainPageViewController.swift
//  iOS-App
//
//  Created by tp on 23/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var loggedUser : String = ""
    var lol = []
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lol.count
    }
}
