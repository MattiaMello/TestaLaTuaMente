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
    var nascosto = false
    
    @IBOutlet weak var lblSecondi: UILabel!
    @IBOutlet weak var lblClassifica: UILabel!
    @IBOutlet weak var lblTiMancano: UILabel!
    @IBOutlet weak var sequence2lbl: UILabel!
    @IBOutlet weak var Sequence: UILabel!
    @IBOutlet weak var UIInput: UITextField!
    @IBOutlet weak var SecondsLeft: UILabel!
    @IBOutlet weak var btnClassifica: UIButton!
    
    @IBAction func gotoClassifica(_ sender: Any) {
        varResetter()
    }
    
    @IBAction func backAction(_ sender: Any) {
        varResetter()
    }
    
    func varResetter () {
        modalita = "L"
        counter = 0
        showCounter = 0
        writeCounter = 0
        inserimento = false
        contaTurni = 0
        daMostrare = "niente"
        parziale = "nonparziale"
        timer = Timer()
        nascosto = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblClassifica.isHidden = true
        btnClassifica.isHidden = true
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
                nascosto = false
                Sequence.isHidden = true
                SecondsLeft.text = "5"
                inserimento = true
                UIInput.text = ""
                showCounter = 0
            }
        } else {
            if(writeCounter > 4) {
                if(inserisci()){
                    inserimento = false
                    writeCounter = 0
                    contaTurni += 1
                    UIInput.text = ""
                    UIInput.isHidden = true
                    Sequence.isHidden = false
                    SecondsLeft.text = "2"
                } else {
                    timer.invalidate()
                    UIInput.isHidden = true
                    Sequence.isHidden = true
                    game.shared.record = contaTurni
                    game.shared.tempo = counter
                    lblTiMancano.isHidden = true
                    lblSecondi.isHidden = true
                    SecondsLeft.isHidden = true
                    btnClassifica.isHidden = false
                    lblClassifica.isHidden = false
                    sequence2lbl.isHidden = true
                    operations.shared.setRecord(record: contaTurni, durataP: counter, tipoP: game.shared.modalita)
                    lblClassifica.text = "Hai totalizzato " + String(contaTurni) + " punti in " + String(counter - 2/*si lo so*/) + " secondi."
                }
            } else {
                if(!nascosto) {
                    UIInput.text = ""
                    nascosto = true
                }
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
    
    //verifica la correttezza della stringa inserita
    
    func inserisci() -> Bool {
        var inserimento = UIInput.text ?? "empty"
        if(daMostrare.contains(inserimento.uppercased()) && inserimento.count == contaTurni + 1){
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
