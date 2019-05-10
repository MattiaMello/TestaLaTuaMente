//
//  gameViewController.swift
//  What a test!
//
//  Created by Mattia Mello on 09/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {

    var modalita = "L"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch game.shared.modalita {
        case "Lettere":
            self.modalita = "L"
            letters()
            break
        case "Numeri":
            self.modalita = "N"
            
            break
        default:
            self.modalita = "ND"
        }
    }
    
    //sequenza mostrata per 2 secondi poi in 5 secondi l'utente deve riscriverla
    
    func letters() {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var shuffled = shuffle(incoming: alphabet)
    }
    
    func numbers() {
        
    }
    
    func shuffle(incoming: String) -> String {
        var array = Array(incoming)
        array.shuffle()
        return String(array)
    }
    
}
