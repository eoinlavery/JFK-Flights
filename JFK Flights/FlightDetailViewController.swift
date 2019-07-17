//
//  FlightDetailViewController.swift
//  JFK Flights
//
//  Created by Eoin Lavery on 14/07/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class FlightDetailViewController: UIViewController {
    
    var flight: Flight!
    
    @IBOutlet weak var airlineLabel: UILabel!
    @IBOutlet weak var flightNameLabel: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var flightStatusLarge: UILabel!
    
    
    @IBOutlet weak var flightDetails: UIView!
    //Departure Labels
    
    @IBOutlet weak var currentDepartureLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var scheduledDepartureLabel: UILabel!
    @IBOutlet weak var airportSignLabel: UILabel!
    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var departureTerminalLabel: UILabel!
    @IBOutlet weak var departureGateLabel: UILabel!
    @IBOutlet weak var planeLabel: UILabel!
    
    //ArrivalDetails
    
    @IBOutlet weak var currentArrivalLabel: UILabel!
    @IBOutlet weak var arrivalDateLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var scheduledArrivalLabel: UILabel!
    @IBOutlet weak var arrivalAirportSignLabel: UILabel!
    @IBOutlet weak var arrivalAirportNameLabel: UILabel!
    @IBOutlet weak var arrivalTerminalLabel: UILabel!
    @IBOutlet weak var arrivalGateLabel: UILabel!
    @IBOutlet weak var baggageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AA 1234"
        self.view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        
        //Airline Labels
        airlineLabel.text = "\(flight.airline.name)"
        flightNameLabel.text = "\(flight.airline.callSign) \(flight.number)"
        
        //Flight Status View
        flightStatusLarge.text = "\(flight.getFlightStatus(statusForFlight: flight))"
        statusView.backgroundColor = evaluateStatusViewColor(forFlight: flight)
        
        switch statusView.backgroundColor! {
        case .red:
            flightStatusLarge.textColor = .white
        case .yellow, .green:
            flightStatusLarge.textColor = .black
        default:
            flightStatusLarge.textColor = .black
        }
        
        departureDateLabel.text = "\(flight.scheduledDeparture.day!)-\(flight.scheduledDeparture.month!)-\(flight.scheduledDeparture.year!)"
        
        departureTimeLabel.text = "\(flight.formatFlightTimes(hour: flight.scheduledDeparture.hour, minute: flight.scheduledDeparture.minute))"
        
        scheduledDepartureLabel.text = "Scheduled: \(flight.formatFlightTimes(hour: flight.scheduledDeparture.hour, minute: flight.scheduledDeparture.minute))"
        
        airportSignLabel.text = "\(flight.departureAirport.callSign)"
        airportNameLabel.text = "\(flight.departureAirport.name)"
        
        arrivalAirportSignLabel.text = "\(flight.arrivalAirport.callSign)"
        arrivalAirportNameLabel.text = "\(flight.arrivalAirport.name)"
        
        
    }
    
    func evaluateStatusViewColor(forFlight: Flight) -> UIColor {
        
        var returnColor: UIColor = .green
        if forFlight.primaryFlightStatus == .Cancelled {
            returnColor = .red
        } else if forFlight.secondaryFlightStatus != nil {
            switch forFlight.secondaryFlightStatus! {
            case .OnTime:
                returnColor = .green
            case .Delayed:
                if forFlight.delayMinutes != nil {
                    if forFlight.delayMinutes! >= 60 {
                        returnColor = .red
                    } else if forFlight.delayMinutes! > 0 {
                        returnColor = .yellow
                    }
                }
            }
        }
        return returnColor
    }
}
