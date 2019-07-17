//
//  DeparturesTableViewController.swift
//  JFK Flights
//
//  Created by Eoin Lavery on 13/07/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class DeparturesTableViewController: UITableViewController {
    
    var flightArray: [Flight] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .always
        title = "Departures"
        flightArray = createData()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorColor = UIColor.white
        tableView.separatorInset = UIEdgeInsets.zero
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return flightArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DepartureFlightCell",
                                                       for: indexPath) as? DepartureCell else {return UITableViewCell()}
        
        let flight: Flight = flightArray[indexPath.row]
        
        //Custom Cell Objects
        cell.backgroundColor = .black
        cell.flightTimeLabel.textColor = .white
        cell.arrivalCityLabel.textColor = .white
        cell.flightIdentifierLabel.textColor = .white
        
        //Assign Labels
        cell.arrivalCityLabel.text = "\(flight.arrivalAirport.city.uppercased()) (\(flight.arrivalAirport.callSign.uppercased()))"
        cell.flightIdentifierLabel.text = "\(flight.airline.callSign) \(flight.number)"
        cell.flightTimeLabel.textColor = evaluateTimeLabelColor(forFlight: flight)
        
        switch flight.primaryFlightStatus {
        case .Cancelled:
            cell.flightTimeLabel.text = "CANCELLED"
        default:
            cell.flightTimeLabel.text = flight.formatFlightTimes(hour: flight.scheduledDeparture.hour, minute: flight.scheduledDeparture.minute)
        }
        
        return cell
    }
    
    func evaluateTimeLabelColor(forFlight: Flight) -> UIColor {
        
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
    
    func evaluateLabelAternativeText(forFlight: Flight) -> String {
        
        var returnString: String
        
        switch forFlight.primaryFlightStatus {
        case .Boarding:
            returnString = "BDING"
        case .Cancelled:
            returnString = "CANC"
        case .EnRoute:
            returnString = "DPRTD"
        case .Landed:
            returnString = "LNDED"
        case .Scheduled:
            returnString = "SCHLD"
        }
        
        return returnString
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        let selectedFlight = flightArray[selectedIndexPath.row]
        let flightDetailVC = segue.destination as? FlightDetailViewController
        flightDetailVC?.flight = selectedFlight
    }
    
    // MARK: - Flights
    
    func createData() -> [Flight]{
        
        //Declare Airlines
        let americanAirlnes = Airline(name: "American Airlines",
                                      callSign: "AA")
        let emirates = Airline(name: "Emirates",
                               callSign: "EK")
        let royalAirMaroc = Airline(name: "Royal Air Maroc",
                                    callSign: "AT")
        let alitalia = Airline(name: "Alitalia",
                               callSign: "AZ")
        let azul = Airline(name: "Azul",
                           callSign: "AD")
        let saAvianca = Airline(name: "SA Avianca",
                                callSign: "AV")
        let virginAtlantic = Airline(name: "Virgin Atlantic",
                                     callSign: "VS")
        let endeavourAir = Airline(name: "Endeavour Air",
                                   callSign: "9E")
        let delta = Airline(name: "Delta Airlines",
                            callSign: "DL")
        let cathayPacific = Airline(name: "Cathay Pacific",
                                    callSign: "CX")
        
        //Declare Airports
        let jfk = Airport(name: "John F. Kennedy Airport",
                          city: "New York",
                          callSign: "JFK")
        let dfw = Airport(name: "Dallas/Fort Worth International Airport",
                          city: "Dallas",
                          callSign: "DFW")
        let bos = Airport(name: "Logan International",
                          city: "Boston",
                          callSign: "BOS")
        let cmn = Airport(name: "Mohamed V International",
                          city: "Casablanca",
                          callSign: "CMN")
        let cle = Airport(name: "Cleveland Hopkins International",
                          city: "Cleveland",
                          callSign: "CLE")
        let fll = Airport(name: "Fort Lauterdale - Hollywood International",
                          city: "Fort Lauterdale",
                          callSign: "FLL")
        let ist = Airport(name: "Istanbul",
                          city: "Istanbul",
                          callSign: "IST")
        let dtw = Airport(name: "Detroit Metropolitan Wayne County",
                          city: "Detroit",
                          callSign: "DTW")
        let atl = Airport(name: "Hartsfield-Jackson Atlanta International",
                          city: "Atlanta",
                          callSign: "ATL")
        let yyz = Airport(name: "Pearson International",
                          city: "Toronto",
                          callSign: "YYZ")
        
        //Declare Planes
        let boeing787800 = Plane(manufacturer: "Boeing",
                                 model: "787-800")
        let embraer190 = Plane(manufacturer: "Embraer",
                               model: "190")
        let boeing7878 = Plane(manufacturer: "Boeing",
                               model: "787-8")
        let bombardierCRJ = Plane(manufacturer: "Bombardier",
                                  model: "CRJ")
        let airbusA320 = Plane(manufacturer: "Airbus",
                               model: "A320")
        let airbus330300 = Plane(manufacturer: "Airbus",
                                 model: "330-300")
        let boeing7478f = Plane(manufacturer: "Boeing",
                                model: "747-8F")
        
        //Declare Flights
        let aa9250 = Flight(airline: americanAirlnes,
                            number: "9250",
                            plane: boeing787800,
                            departureAirport: jfk,
                            arrivalAirport: dfw,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour: 12,
                                                               minute: 09),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 14,
                                                             minute: 45),
                            primaryFlightStatus: .Landed,
                            isCodeShare:false,
                            flightType: .Departure,
                            codeShareCallSign: nil,
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 13,
                                                            minute: 28),
                            actualArrival: DateComponents(year: 2019,
                                                          month: 7,
                                                          day: 12,
                                                          hour: 16,
                                                          minute: 09),
                            delayMinutes: 84,
                            secondaryFlightStatus: .Delayed,
                            departureTerminal: "8",
                            departureGate: "7",
                            arrivalTerminal: "A",
                            arrivalGate: "A38",
                            arrivalBaggage: "A29")
        
        let ek6705 = Flight(airline: emirates,
                            number: "6705",
                            plane: embraer190,
                            departureAirport: jfk,
                            arrivalAirport: bos,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour: 12,
                                                               minute: 14),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 13,
                                                             minute: 30),
                            primaryFlightStatus: .Landed,
                            isCodeShare: true,
                            flightType: .Departure,
                            codeShareCallSign: "B61318",
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 12,
                                                            minute: 19),
                            actualArrival: DateComponents(year: 2019,
                                                          month: 7,
                                                          day: 12,
                                                          hour: 13,
                                                          minute: 20),
                            delayMinutes: nil,
                            secondaryFlightStatus: .OnTime,
                            departureTerminal: "5",
                            departureGate: "4",
                            arrivalTerminal: "C",
                            arrivalGate: "C12",
                            arrivalBaggage: nil)
        
        let at203 = Flight(airline: royalAirMaroc,
                            number: "203",
                            plane: boeing7878,
                            departureAirport: jfk,
                            arrivalAirport: cmn,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour: 12,
                                                               minute: 10),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 11,
                                                             minute: 59),
                            primaryFlightStatus: .EnRoute,
                            isCodeShare: false,
                            flightType: .Departure,
                            codeShareCallSign: nil,
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 12,
                                                            minute: 50),
                            actualArrival: nil,
                            delayMinutes: 40,
                            secondaryFlightStatus: .Delayed,
                            departureTerminal: "1",
                            departureGate: nil,
                            arrivalTerminal: "2",
                            arrivalGate: nil,
                            arrivalBaggage: nil)
        
        let az5877 = Flight(airline: alitalia,
                            number: "5877",
                            plane: bombardierCRJ,
                            departureAirport: jfk,
                            arrivalAirport: cle,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour:12,
                                                               minute: 15),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 12,
                                                             minute: 12),
                            primaryFlightStatus: .Landed,
                            isCodeShare: true,
                            flightType: .Departure,
                            codeShareCallSign: "9E3502",
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 12,
                                                            minute: 12),
                            actualArrival: DateComponents(year: 2019,
                                                          month: 7,
                                                          day: 12,
                                                          hour: 13,
                                                          minute: 58),
                            delayMinutes: nil,
                            secondaryFlightStatus: .OnTime,
                            departureTerminal: "4",
                            departureGate: "B46",
                            arrivalTerminal: nil,
                            arrivalGate: "B4",
                            arrivalBaggage: nil)
        
        let ad7423 = Flight(airline: azul,
                            number: "7423",
                            plane: airbusA320,
                            departureAirport: jfk,
                            arrivalAirport: fll,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour: 12,
                                                               minute: 36),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 15,
                                                             minute: 50),
                            primaryFlightStatus: .Landed,
                            isCodeShare: true,
                            flightType: .Departure,
                            codeShareCallSign: "B6201",
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 12,
                                                            minute: 43),
                            actualArrival: DateComponents(year: 2019,
                                                          month: 7,
                                                          day: 12,
                                                          hour: 15,
                                                          minute: 29),
                            delayMinutes: nil,
                            secondaryFlightStatus: .OnTime,
                            departureTerminal: "5",
                            departureGate: "1",
                            arrivalTerminal: "3",
                            arrivalGate: "F10",
                            arrivalBaggage: nil)
        
        let av6624 = Flight(airline: saAvianca,
                            number: "6624",
                            plane: airbus330300,
                            departureAirport: jfk,
                            arrivalAirport: ist,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour: 12,
                                                               minute: 30),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 05,
                                                             minute: 15),
                            primaryFlightStatus: .EnRoute,
                            isCodeShare: true,
                            flightType: .Departure,
                            codeShareCallSign: "TK4",
                            estimatedDeparture: nil,
                            estimatedArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 13,
                                                             hour: 05,
                                                             minute: 15),
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 12,
                                                            minute: 48),
                            actualArrival: nil,
                            delayMinutes: 21,
                            secondaryFlightStatus: .Delayed,
                            departureTerminal: "1",
                            departureGate: nil,
                            arrivalTerminal: "I",
                            arrivalGate: nil,
                            arrivalBaggage: nil)
        
        let vs4631 = Flight(airline: virginAtlantic,
                            number: "4631",
                            plane: bombardierCRJ,
                            departureAirport: jfk,
                            arrivalAirport: dtw,
                            scheduledDeparture: DateComponents(year: 2019,
                                                               month: 7,
                                                               day: 12,
                                                               hour: 12,
                                                               minute: 59),
                            scheduledArrival: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 15,
                                                             minute: 03),
                            primaryFlightStatus: .Landed,
                            isCodeShare: true,
                            flightType: .Departure,
                            codeShareCallSign: "9E3409",
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: DateComponents(year: 2019,
                                                            month: 7,
                                                            day: 12,
                                                            hour: 13,
                                                            minute: 38),
                            actualArrival: DateComponents(year: 2019,
                                                          month: 7,
                                                          day: 12,
                                                          hour: 15,
                                                          minute: 46),
                            delayMinutes: 43,
                            secondaryFlightStatus: .Delayed,
                            departureTerminal: "4",
                            departureGate: "B48",
                            arrivalTerminal: "M",
                            arrivalGate: "A29",
                            arrivalBaggage: nil)
        
        let v9E5573 = Flight(airline: endeavourAir,
                                  number: "5573",
                                  plane: bombardierCRJ,
                                  departureAirport: jfk,
                                  arrivalAirport: atl,
                                  scheduledDeparture: DateComponents(year: 2019,
                                                                     month: 7,
                                                                     day: 12,
                                                                     hour: 13,
                                                                     minute: 30),
                                  scheduledArrival: DateComponents(year: 2019,
                                                                   month: 7,
                                                                   day: 12,
                                                                   hour: 15,
                                                                   minute: 00),
                                  primaryFlightStatus: .Cancelled,
                                  isCodeShare: true,
                                  flightType: .Departure,
                                  codeShareCallSign: "DL5573",
                                  estimatedDeparture: nil,
                                  estimatedArrival: nil,
                                  actualDeparture: nil,
                                  actualArrival: nil,
                                  delayMinutes: nil,
                                  secondaryFlightStatus: nil,
                                  departureTerminal: "4",
                                  departureGate: "B23",
                                  arrivalTerminal: nil,
                                  arrivalGate: nil,
                                  arrivalBaggage: nil)
        
        let dl5573 = Flight(airline: delta,
                            number: "5573",
                            plane: bombardierCRJ,
                            departureAirport: jfk,
                            arrivalAirport: atl,
                            scheduledDeparture: v9E5573.scheduledDeparture,
                            scheduledArrival: v9E5573.scheduledArrival,
                            primaryFlightStatus: .Cancelled,
                            isCodeShare: true,
                            flightType: .Departure,
                            codeShareCallSign: "9E5573",
                            estimatedDeparture: nil,
                            estimatedArrival: nil,
                            actualDeparture: nil,
                            actualArrival: nil,
                            delayMinutes: nil,
                            secondaryFlightStatus: nil,
                            departureTerminal: "4",
                            departureGate: "B23",
                            arrivalTerminal: nil,
                            arrivalGate: nil,
                            arrivalBaggage: nil)
        
        let cx85 = Flight(airline: cathayPacific,
                          number: "85",
                          plane: boeing7478f,
                          departureAirport: jfk,
                          arrivalAirport: yyz,
                          scheduledDeparture: DateComponents(year: 2019,
                                                             month: 7,
                                                             day: 12,
                                                             hour: 13,
                                                             minute: 40),
                          scheduledArrival: DateComponents(year: 2019,
                                                           month: 7,
                                                           day: 12),
                          primaryFlightStatus: .Landed,
                          isCodeShare: false,
                          flightType: .Departure,
                          codeShareCallSign: nil,
                          estimatedDeparture: nil,
                          estimatedArrival: nil,
                          actualDeparture: DateComponents(year: 2019,
                                                          month: 7,
                                                          day: 12,
                                                          hour: 13,
                                                          minute: 40),
                          actualArrival: nil,
                          delayMinutes: nil,
                          secondaryFlightStatus: nil,
                          departureTerminal: nil,
                          departureGate: nil,
                          arrivalTerminal: nil,
                          arrivalGate: nil,
                          arrivalBaggage: nil)

        flightArray.append(contentsOf: [aa9250,
                                        ek6705,
                                        at203,
                                        az5877,
                                        ad7423,
                                        av6624,
                                        vs4631,
                                        v9E5573,
                                        dl5573,
                                        cx85])
        return flightArray
        }
}

