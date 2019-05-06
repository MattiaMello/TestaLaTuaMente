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

class ID : Decodable {
    var ID : String
}

class records : Decodable {
    var myRecord : Int
    var myName : String
    var othRecord0 : Int
    var othName0: String
    var othRecord1 : Int
    var othName1: String
    var othRecord2 : Int
    var othName2: String
    var othRecord3 : Int
    var othName3: String
    var othRecord4 : Int
    var othName4: String
    var othRecord5 : Int
    var othName5: String
    var othRecord6 : Int
    var othName6: String
    var othRecord7 : Int
    var othName7: String
    var othRecord8 : Int
    var othName8: String
    var othRecord9 : Int
    var othName9: String
}

class operations {
    
    func setRecord() {
        
    }
    
    func getRecords() {
        
    }
    
    func getID() -> String {
        return "null"
    }
    
    func writeToNSUserDefaults(toWrite : String) {
        
    }
}
