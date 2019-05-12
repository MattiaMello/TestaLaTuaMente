//
//  game.swift
//  What a test!
//
//  Created by Mattia Mello on 07/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import Foundation


class game {
    public var modalita : String
    public var record : Int
    public var tempo : Int
    public var nomePlayer : String
    private init() {
        modalita = "Lettere"
        record = 0
        tempo = 0
        nomePlayer = "Anonimo"
    }
    static let shared = game()
}
