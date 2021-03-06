//
//  ViewController.swift
//  What a test!
//
//  Created by Mattia Mello on 02/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let pwDataSource = ["Lettere", "Numeri"]
    let operationClass = operations.self
    let gameController = game.self
    
    @IBOutlet weak var GameModePicker: UIPickerView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBAction func playPressed(_ sender: Any) {
        game.shared.nomePlayer = playerName.text ?? "Anonimo"
        operationClass.shared.updateName(name: playerName.text!)
    }
    @IBAction func proerlyFormattedName(_ sender: Any) {
        if(playerName.text != "" && game.shared.nomePlayer != "") {
            playButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (game.shared.nomePlayer != "" && game.shared.nomePlayer != "Anonimo") {
            playerName.text = game.shared.nomePlayer
        }
        
        playerName.delegate = self as! UITextFieldDelegate
        
        // Do any additional setup after loading the view, typically from a nib.
        GameModePicker.dataSource = self
        GameModePicker.delegate = self
        playButton.isEnabled = false
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerTrigger), userInfo: nil, repeats: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func timerTrigger() {
        if(operations.shared.record.myName != "Anonimo" && operations.shared.record.myName != "")
        {
            playerName.text = operations.shared.record.myName
            playerName.isEnabled = false
        }
        if(playerName.text != "") {
            playButton.isEnabled = true
        }
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
