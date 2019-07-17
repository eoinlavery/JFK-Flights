//
//  Airline.swift
//  JFK Flights
//
//  Created by Eoin Lavery on 13/07/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//
import UIKit
import Foundation

class Airline {
    
    var name: String
    var callSign: String
    
    init(name: String,
         callSign:String)
    {
        self.name = name
        self.callSign = callSign
    }
}
