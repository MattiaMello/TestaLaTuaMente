//
//  GameResultViewController.swift
//  What a test!
//
//  Created by Mattia Mello on 10/05/2019.
//  Copyright © 2019 Mattia Mello. All rights reserved.
//

import UIKit

class GameResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var resultDict = operations.shared.record.nsDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (resultDict.count/2)
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        /*return ["myRecord": myRecord,
         "myName": myName*/
        var cheDevoFare = "my"
        if(indexPath.row > 0) {
            cheDevoFare = "oth"
        }
        
        switch cheDevoFare {
        case "my":
            cell.textLabel?.text = unificaMy(a: resultDict["myRecord"] as? Int ?? -1, b: resultDict["myName"] as? String ?? "Err")
        case "oth":
            let dict = resultDict
            cell.textLabel?.text = unificaMy(a: resultDict[String("othRecord" + String(indexPath.row-1))] as? Int ?? -1, b: resultDict[String("othName" + String(indexPath.row-1))] as? String ?? "Err")
            break
        default: break
        }
        return cell
    }
    
    func unificaMy(a: Int, b:String) -> String {
        return b + " ha totalizzato " + String(a) + " punti."
    }
}
