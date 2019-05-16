//
//  operations.swift
//  What a test!
//
//  Created by Mattia Mello on 05/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import Foundation

//scrivere i metodi di setRecord, getRecord e GID (torna la stringa ID)
//scrivere gli oggetti necessari
//fare memorizzazione su nsuserdefault

struct Records : Decodable {
    let myRecord : Int
    let myName : String
    let othRecord0 : Int
    let othName0 : String
    let othRecord1 : Int
    let othName1 : String
    let othRecord2 : Int
    let othName2 : String
    let othRecord3 : Int
    let othName3 : String
    let othRecord4 : Int
    let othName4 : String
    let othRecord5 : Int
    let othName5 : String
    let othRecord6 : Int
    let othName6 : String
    let othRecord7 : Int
    let othName7 : String
    let othRecord8 : Int
    let othName8 : String
    let othRecord9 : Int
    let othName9 : String
    init() {
        myRecord = -1
        myName = "Anonimo"
        othRecord0 = -1
        othName0 = "Anonimo"
        othRecord1 = -1
        othName1 = "Anonimo"
        othRecord2 = -1
        othName2 = "Anonimo"
        othRecord3 = -1
        othName3 = "Anonimo"
        othRecord4 = -1
        othName4 = "Anonimo"
        othRecord5 = -1
        othName5 = "Anonimo"
        othRecord6 = -1
        othName6 = "Anonimo"
        othRecord7 = -1
        othName7 = "Anonimo"
        othRecord8 = -1
        othName8 = "Anonimo"
        othRecord9 = -1
        othName9 = "Anonimo"
    }
    var dictionary: [String: Any] {
        return ["myRecord": myRecord,
                "myName": myName,
                "othRecord0": othRecord0,
                "othName0": othName0,
                "othRecord1": othRecord1,
                "othName1": othName1,
                "othRecord2": othRecord2,
                "othName2": othName2,
                "othRecord3": othRecord3,
                "othName3": othName3,
                "othRecord4": othRecord4,
                "othName4": othName4,
                "othRecord5": othRecord5,
                "othName5": othName5,
                "othRecord6": othRecord6,
                "othName6": othName6,
                "othRecord7": othRecord7,
                "othName7": othName7,
                "othRecord8": othRecord8,
                "othName08": othName8,
                "othRecord9": othRecord9,
                "othName09": othName9,]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}

struct Identification : Decodable{
    let ID : String
    init() {
        ID = "BBBBBBBBBB"
    }
}

class operations {
    
    public var ID = "AAAAAAAAAA"
    public var record = Records()
    
    //operazioni:
    
    //verifico che il telefono abbia un ID, se lo ha lo salvo in una varibile della classe, se non lo ha faccio una richiesta al web service che me lo da
    //scarica i record
    //setta il record (se maggiore di quello effettuato)
    
    private init() {
        ID = UserDefaults.standard.value(forKey: "ID") as? String ?? "ZZZZZZZZZZ"
        if(ID == "ZZZZZZZZZZ"){
            ID = "IDDALWEBSERVICE"//qua metodo che scarica un ID
            self.getID(outIDmethod: { (phid) in
                self.ID = phid
                game.shared.nomePlayer = self.ID
                UserDefaults.standard.setValue(phid, forKey: "ID")
            })
        }
        getRecord()
    }
    
    static let shared = operations()
    
    public func setRecord(record: Int, durataP: Int, tipoP: String) {
        var tipo = "L"
        switch tipoP {
        case "Lettere":
            tipo = "L"
            break
        case "Numeri":
            tipo = "N"
            break
        default:
            tipo = "NaN"
        }
        let jsonURL = "http://testalatuamente.altervista.org/API/operations.php?action=SR&phid=" + ID + "&Record=" + String(record) + "&NomeG=&TipoP=" + tipo + "&DurataP=" + String(durataP)
        
        let url = URL(string: jsonURL)!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            }.resume()
    }
    
    public func updateName(name: String) {
        //da fare da fare da fare da fare
        //UPDNM http://testalatuamente.altervista.org/API/operations.php?action=UPDNM&phid=&Record=&NomeG=&TipoP=&DurataP=
        
        let jsonURL = "http://testalatuamente.altervista.org/API/operations.php?action=UPDNM&phid=" + ID + "&Record=&NomeG=" + name + "&TipoP=&DurataP="
        
        let url = URL(string: jsonURL)!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            }.resume()
    }
    
    func getID(outIDmethod:@escaping (String) -> ()) {
        let jsonURL = "http://testalatuamente.altervista.org/API/operations.php?action=GID&phid=&Record=&NomeG=&TipoP=&DurataP="
        
        let url = URL(string: jsonURL)!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let inID = try JSONDecoder().decode(Identification.self, from: data)
                
                DispatchQueue.main.async {
                    outIDmethod(inID.ID)
                    print(inID.ID)
                    self.ID = inID.ID
                }
            } catch let jsnErr {
                print("errore durante la deserializzazione del JSON: ", jsnErr)
            }
            
        }.resume()
    }
    
    //-------------------------------------------------
    
    func getRecord() {
        self.downloadRecord(outRecordMethod: { (varRecord) in
            self.record = varRecord
        })
    }
    
    private func downloadRecord(outRecordMethod:@escaping (Records) -> ()) {
        
        let jsonURL = "http://testalatuamente.altervista.org/API/operations.php?action=GR&phid="+ID+"&Record=&NomeG=&TipoP=&DurataP="
        
        let url = URL(string: jsonURL)!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                let recordVar = try JSONDecoder().decode(Records.self, from: data)
                
                DispatchQueue.main.async {
                    outRecordMethod(recordVar)
                    print("Entrato")
                    print(recordVar.myName)
                }
                
            } catch let jsnErr {
                print("errore durante la deserializzazione del JSON: ", jsnErr)
            }
            
        }.resume()
    }
}
