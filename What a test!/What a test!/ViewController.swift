//
//  ViewController.swift
//  What a test!
//
//  Created by Mattia Mello on 02/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var label: UILabel!
    @IBAction func press(_ sender: Any) {
        let operationsClass = operations()
        label.text = operationsClass.getID()
    }
}
