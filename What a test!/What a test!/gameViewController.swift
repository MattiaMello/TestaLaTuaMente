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
    var counter = 0
    var showCounter = 0
    var writeCounter = 0
    var inserimento = false
    var contaTurni = 0
    var daMostrare = "niente"
    var parziale = "nonparziale"
    var timer = Timer()
    
    @IBOutlet weak var Sequence: UILabel!
    @IBOutlet weak var UIInput: UITextField!
    @IBOutlet weak var SecondsLeft: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch game.shared.modalita {
        case "Lettere":
            self.modalita = "L"
            letters()
            break
        case "Numeri":
            self.modalita = "N"
            numbers()
            break
        default:
            self.modalita = "ND"
        }
    }
    
    //sequenza mostrata per 2 secondi poi in 5 secondi l'utente deve riscriverla
    
    func letters() {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
        daMostrare = shuffle(incoming: alphabet)
        gioco()
    }
    
    func numbers() {
        let numbers = "123456789012345678901234567890123456789012345678901234567890123456789012345678"
        daMostrare = shuffle(incoming: numbers)
        gioco()
    }
    
    func gioco() {
        UIInput.isHidden = true
        Sequence.isHidden = false
        parziale = String(daMostrare.prefix(1))
        mostra(stringa: parziale)
        SecondsLeft.text = "2"
        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerTrigger), userInfo: nil, repeats: true)
        counter = 0
    }
    
    @objc func timerTrigger() {
        counter += 1
        print(counter)
        if(!inserimento) {
            if(showCounter < 2) {
                UIInput.isHidden = true
                Sequence.isHidden = false
                showCounter += 1
                parziale = String(daMostrare.prefix(contaTurni + 1))
                let toShow = (2 - showCounter)
                SecondsLeft.text = String(toShow)
                mostra(stringa: parziale)
            } else {
                UIInput.isHidden = false
                Sequence.isHidden = true
                SecondsLeft.text = "5"
                inserimento = true
                showCounter = 0
            }
        } else {
            if(writeCounter > 4) {
                if(inserisci()){
                    inserimento = false
                    writeCounter = 0
                    contaTurni += 1
                    UIInput.isHidden = true
                    Sequence.isHidden = false
                    SecondsLeft.text = "2"
                } else {
                    //timer.stop()
                    game.shared.record = contaTurni
                    game.shared.tempo = counter
                    let nextScreen  = GameResultViewController()
                    self.navigationController?.pushViewController(nextScreen, animated: true)
                }
            } else {
                UIInput.isHidden = false
                Sequence.isHidden = true
                writeCounter += 1
                let toShow = (5 - writeCounter)
                SecondsLeft.text = String(toShow)
            }
        }
    }
    
    func mostra(stringa: String) {
        Sequence.text = stringa
    }
    
    func inserisci() -> Bool { //verifica la correttezza della stringa inserita
        var inserimento = UIInput.text ?? "empty"
        if(daMostrare.contains(inserimento.uppercased())){
            return true
        }
        return false
    }
    
    func shuffle(incoming: String) -> String {
        var array = Array(incoming)
        array.shuffle()
        return String(array)
    }
}
