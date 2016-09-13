//
//  FourSqaureAPI.swift
//  Expl0r
//
//  Created by Raunak Gupta on 10/9/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import Foundation
import QuadratTouch
import MapKit
import RealmSwift

struct API {
    struct notifications {
        static let venuesUpdated = "venues updated"
    }
}

struct VenueStruct {
    var id = ""
    var name = ""
    var type = ""
    var latitude: Double = 0
    var longitude: Double = 0
}

protocol VenueAPIDelegate: class {
    func didReceive(venues: [VenueStruct])
}

class VenueAPI
{
    //static let sharedInstance = VenueAPI()
    var session: Session?
    weak var delegate: VenueAPIDelegate?
    
    init(currDelegate: VenueAPIDelegate?)
    {
        /* set up client and start session */
        
        let client = Client(clientID: "TUCVW5DJVEFYNEWNOAKJ0PFPNNNI4SLHTPWO1U0YWDICCQO5", clientSecret: "BJLNMQTWLNHXGHW3MYDQD2O1VYEHK12TFMHD2YCHHDA0MMI0", redirectURL: "")
        let configuration = Configuration(client:client)
        Session.setupSharedSessionWithConfiguration(configuration)
        self.session = Session.sharedSession()
        delegate = currDelegate

        
    }

    func getChosenVenue(location: CLLocation, queryType: String) -> Void {
        var chosenVenues = [VenueStruct]()
        if let session = self.session {
            var parameters = location.parameters()
            parameters += [Parameter.query:queryType]
            parameters += [Parameter.radius: "5000"]
            parameters += [Parameter.limit: "20"]
            
            let searchTask = session.venues.search(parameters)
            {
                (result) -> Void in
                
                if let response = result.response
                {
                    if let venues = response["venues"] as? [[String: AnyObject]]
                    {
                        for venue in venues
                        {
                            var currVenue = VenueStruct()
                            currVenue.type = queryType
                            
                            if let id = venue["id"] as? String
                            {
                                currVenue.id = id
                            }
                            if let name = venue["name"] as? String
                            {
                                currVenue.name = name
                            }
                            if let venueLocation = venue["location"] as? [String: AnyObject]
                            {
                                if let latitude = venueLocation["lat"] as? Double
                                {
                                    currVenue.latitude = latitude
                                }
                                if let longitude = venueLocation["lng"] as? Double
                                {
                                    currVenue.longitude = longitude
                                }
                            }
                            chosenVenues.append(currVenue)
                        }
                        self.delegate?.didReceive(chosenVenues)
                    }
                }
            }
            searchTask.start()
        }
        return
    }
}

extension CLLocation
{
    func parameters() -> Parameters
    {
        let ll      = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        let llAcc   = "\(self.horizontalAccuracy)"
        let alt     = "\(self.altitude)"
        let altAcc  = "\(self.verticalAccuracy)"
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc
        ]
        return parameters
    }
}



