//
//  Plane.swift
//  JFK Flights
//
//  Created by Eoin Lavery on 13/07/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//
import UIKit
import Foundation

class Plane {
    
    var manufacturer: String
    var model: String
    
    init(manufacturer: String, model: String)
    {
        self.manufacturer = manufacturer
        self.model = model
    }
}
