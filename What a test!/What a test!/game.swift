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
    var record = 0
    private init() {
        modalita = "Lettere"
    }
    static let shared = game()
}
