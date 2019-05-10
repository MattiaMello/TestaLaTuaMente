//
//  ViewController.swift
//  What a test!
//
//  Created by Mattia Mello on 02/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let pwDataSource = ["Lettere", "Numeri"]
    
    let operationClass = operations()
    let gameController = game.self

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GameModePicker.dataSource = self
        GameModePicker.delegate = self
    }
    @IBOutlet weak var GameModePicker: UIPickerView!
    @IBAction func start(_ sender: Any) {
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pwDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameController.shared.modalita = pwDataSource[row]
        print(pwDataSource[row])
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pwDataSource[row]
    }
}
