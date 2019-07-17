//
//  Flight.swift
//  JFK Flights
//
//  Created by Eoin Lavery on 13/07/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//
import UIKit
import Foundation

class Flight {
    
    //Flight Identifiers
    var airline: Airline
    var number: String
    var plane: Plane
    
    //Flight Airports
    var departureAirport: Airport
    var arrivalAirport: Airport
    
    //Flight Times
    var scheduledDeparture: DateComponents
    var scheduledArrival: DateComponents
    
    var estimatedDeparture: DateComponents?
    var estimatedArrival: DateComponents?
    
    var actualDeparture: DateComponents?
    var actualArrival: DateComponents?
    
    var delayMinutes: Int?
    
    //Code Sign Flight
    var isCodeShare: Bool
    var codeShareCallSign: String?
    
    //Terminals, Gates and Baggage
    var departureTerminal: String?
    var departureGate: String?
    
    var arrivalTerminal: String?
    var arrivalGate: String?
    var arrivalBaggage: String?
    
    //Primary Flight Status Enum
    enum primaryFlightStatus { 
        case Cancelled
        case Landed
        case Scheduled
        case Boarding
        case EnRoute
    }
    
    //Secondary Flight Status Enum
    enum secondaryFlightStatus {
        case Delayed
        case OnTime
    }
    var primaryFlightStatus: primaryFlightStatus
    var secondaryFlightStatus: secondaryFlightStatus?
    
    //Flight Type Enum
    enum FlightType {
        case Departure
        case Arrival
    }
    var flightType: FlightType
    
    init(airline: Airline, number: String, plane: Plane, departureAirport: Airport, arrivalAirport: Airport, scheduledDeparture:DateComponents, scheduledArrival: DateComponents, primaryFlightStatus: primaryFlightStatus, isCodeShare: Bool, flightType: FlightType, codeShareCallSign: String?, estimatedDeparture: DateComponents?, estimatedArrival: DateComponents?, actualDeparture: DateComponents?, actualArrival: DateComponents?, delayMinutes: Int?, secondaryFlightStatus: secondaryFlightStatus?, departureTerminal: String?, departureGate: String?, arrivalTerminal: String?, arrivalGate: String?, arrivalBaggage: String?) {
        
            //Initialiser Parameters
            self.airline = airline
            self.number = number
            self.plane = plane
            self.departureAirport = departureAirport
            self.arrivalAirport = arrivalAirport
            self.scheduledDeparture = scheduledDeparture
            self.scheduledArrival = scheduledArrival
            self.primaryFlightStatus = primaryFlightStatus
            self.isCodeShare = isCodeShare
            self.flightType = flightType
        
            //Optional Parameters
            self.codeShareCallSign = codeShareCallSign
            self.estimatedArrival = estimatedArrival
            self.estimatedDeparture = estimatedDeparture
            self.actualArrival = actualArrival
            self.actualDeparture = actualDeparture
            self.delayMinutes = delayMinutes
            self.secondaryFlightStatus = secondaryFlightStatus
            self.departureTerminal = departureTerminal
            self.departureGate = departureGate
            self.arrivalTerminal = arrivalTerminal
            self.arrivalGate = arrivalGate
            self.arrivalBaggage = arrivalBaggage
    }
    
    func formatFlightTimes(hour: Int?, minute: Int?) -> String {
        let hourString: String = "\(hour!)"
        var minuteString: String = "\(minute!)"
        let returnString: String
        
        switch minuteString {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            minuteString = "0\(minuteString)"
        default:
            break
    }
        
        returnString = "\(hourString):\(minuteString)"
        return returnString
    }
    
    func getFlightStatus(statusForFlight: Flight) -> String {
        
        let primaryFlightStatus:String
        let secondaryFlightStatus: String
        let returnString: String
        
        switch statusForFlight.primaryFlightStatus {
        case .Cancelled:
            primaryFlightStatus = "Cancelled"
        case .EnRoute:
            primaryFlightStatus = "En Route"
        case .Landed:
            primaryFlightStatus = "Landed"
        case .Scheduled:
            primaryFlightStatus = "Scheduled"
        case .Boarding:
            primaryFlightStatus = "Boarding"
        }
        
        if statusForFlight.secondaryFlightStatus != nil {
            switch statusForFlight.secondaryFlightStatus! {
            case .Delayed:
                secondaryFlightStatus = " - Delayed"
            case .OnTime:
                secondaryFlightStatus = " - On Time"
            }
        } else {
            secondaryFlightStatus = ""
        }
        
        returnString = "\(primaryFlightStatus)\(secondaryFlightStatus)"
        return returnString
    }
    
    func getTerminal(terminalForFlight: Flight) -> String{
        if terminalForFlight.departureTerminal != nil {
            return terminalForFlight.departureTerminal!
        } else {
            return "TBD"
        }
    }
    
    func getGate(gateForFlight: Flight) -> String{
        if gateForFlight.departureTerminal != nil {
            return gateForFlight.departureTerminal!
        } else {
            return "TBD"
        }
    }
    
    func getBaggage(baggageForFlight: Flight) -> String{
        if baggageForFlight.departureTerminal != nil {
            return baggageForFlight.departureTerminal!
        } else {
            return "TBD"
        }
    }
    
}
