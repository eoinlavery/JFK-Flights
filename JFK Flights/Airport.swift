//
//  Airport.swift
//  JFK Flights
//
//  Created by Eoin Lavery on 13/07/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//
import UIKit
import Foundation

class Airport {
    
    var name: String
    var city: String
    var callSign: String
    
    init(name: String, city: String,
         callSign: String)
    {
        self.name = name
        self.city = city
        self.callSign = callSign
    }
}
