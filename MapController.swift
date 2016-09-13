//
//  MapController.swift
//  Expl0r
//
//  Created by Linda Xia on 9/10/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

var locValue = CLLocationCoordinate2D()
var currentVenues = [Artwork]()
var foodQueryTypes = ["Italian", "Pizza", "Thai", "Chinese","Fast food","Steak","Indian","Mexican","Vegetarian","Cheap","Fine dining"]
var snackQueryTypes = ["Breakfast","cafes","icecream","coffee","tea","desserts","cookies"]
var funQueryTypes = ["shopping","cinemas","parks","statues","monuments","mountains","museums","sports","adventure"]

class MapController: UIViewController, VenueAPIDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var initialLocation = CLLocation(latitude: 39.952073, longitude: -75.205591)
    var listVenues = [Artwork]()
    
    // Unwinding segue
    @IBAction func unwindToMapController(segue: UIStoryboardSegue)
    {
        
    }
    
    
    
    func didReceive(venues: [VenueStruct]) -> Void {
        let index = Int(arc4random_uniform(UInt32(venues.count)))
        let currVenue = venues[index]
        let latLong = CLLocationCoordinate2D(latitude: currVenue.latitude, longitude: currVenue.longitude)
        //below are changes
        //for reg in locationManager.monitoredRegions {
        //    locationManager.stopMonitoringForRegion(reg)
        //}
//        
//        let thisRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 40.0, longitude: -75.0), radius: 25000.0, identifier: "Philly")
//        locationManager.startMonitoringForRegion(thisRegion)
//        let circle = MKCircle(centerCoordinate: latLong, radius: 100.0)
//        mapView.addAnnotation(circle)
//        
        let london = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13), radius: 25000.0, identifier: "London")
        locationManager.startMonitoringForRegion(london)
        
        let newRegion =  CLCircularRegion(center: CLLocationCoordinate2D(latitude: currVenue.latitude, longitude: currVenue.longitude), radius: 1000, identifier: currVenue.name)
        locationManager.startMonitoringForRegion(newRegion)
        let circle = MKCircle(centerCoordinate: latLong, radius: 100.0)
        mapView.addAnnotation(circle)
        
        //above are changes
        let currPoint = Artwork(title: currVenue.name, discipline: currVenue.type, coordinate: latLong, region: newRegion) //also added region
        self.listVenues.append(currPoint)
        print(self.listVenues.count)
        mapView.addAnnotation(currPoint)
    }
    var counter = 0
    var goButtonCounter = 0
    var currentVenueIndex = 0
    
    func startJourney() {
        let lat = self.listVenues[currentVenueIndex % listVenues.count].coordinate.latitude
        let lng = self.listVenues[currentVenueIndex % listVenues.count].coordinate.longitude
        let loc = CLLocation(latitude: lat, longitude: lng)
        goButtonCounter = goButtonCounter + 1
        self.centerMapAtLocation(loc)
        
    }
    
    @IBAction func GoButton(sender: UIButton) {
        self.startJourney()
    }
    
    @IBAction func lyftButton(sender: UIButton) {
        let myApp = UIApplication.sharedApplication()
        let pickupLat = locValue.latitude
        let pickuplng = locValue.longitude
        let lyftAppURL = NSURL(string: "lyft://ridetype?id=lyft&partner=HB9HQOGiEuNE&pickup[latitude]=\(pickupLat)&pickup[longitude]=\(pickuplng)&destination[latitude]=\(self.listVenues[currentVenueIndex].coordinate.latitude)&destination[longitude]=\(self.listVenues[currentVenueIndex].coordinate.longitude)")!
        //counter = counter + 1
        if myApp.canOpenURL(lyftAppURL) {
            // Lyft is installed; launch it
            //let hailRideURL = NSURL(string: "lyft://")
            myApp.openURL(lyftAppURL)
        } else {
            // Lyft not installed; open App Store
            let lyftAppStoreURL = NSURL(string: "https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082")!
            myApp.openURL(lyftAppStoreURL)
        }
    }
    func executeHalfDay(fourSquareAPI: VenueAPI, location: CLLocation) {
        let lunchQuery = foodQueryTypes[Int(arc4random_uniform(UInt32(foodQueryTypes.count)))]
        let firstFunQuery = funQueryTypes[Int(arc4random_uniform(UInt32(funQueryTypes.count)))]
        let secondFunQuery = funQueryTypes[Int(arc4random_uniform(UInt32(funQueryTypes.count)))]
        let snackQuery = snackQueryTypes[Int(arc4random_uniform(UInt32(snackQueryTypes.count)))]
        fourSquareAPI.getChosenVenue(location, queryType: lunchQuery)
        fourSquareAPI.getChosenVenue(location, queryType: firstFunQuery)
        fourSquareAPI.getChosenVenue(location, queryType: secondFunQuery)
        fourSquareAPI.getChosenVenue(location, queryType: snackQuery)
    }
    
    func executeFullDay(foursquareAPI: VenueAPI, location: CLLocation) {
        let breakFastQuery = snackQueryTypes[Int(arc4random_uniform(UInt32(snackQueryTypes.count)))]
        let firstFunQuery = funQueryTypes[Int(arc4random_uniform(UInt32(funQueryTypes.count)))]
        let secondFunQuery = funQueryTypes[Int(arc4random_uniform(UInt32(funQueryTypes.count)))]
        let lunchQuery = foodQueryTypes[Int(arc4random_uniform(UInt32(foodQueryTypes.count)))]
        let thirdFunQuery = funQueryTypes[Int(arc4random_uniform(UInt32(funQueryTypes.count)))]
        let snackQuery = snackQueryTypes[Int(arc4random_uniform(UInt32(snackQueryTypes.count)))]
        let fourthFunQuery = funQueryTypes[Int(arc4random_uniform(UInt32(funQueryTypes.count)))]
        let dinnerQuery = foodQueryTypes[Int(arc4random_uniform(UInt32(foodQueryTypes.count)))]
        foursquareAPI.getChosenVenue(location, queryType: breakFastQuery)
        foursquareAPI.getChosenVenue(location, queryType: firstFunQuery)
        foursquareAPI.getChosenVenue(location, queryType: secondFunQuery)
        foursquareAPI.getChosenVenue(location, queryType: lunchQuery)
        foursquareAPI.getChosenVenue(location, queryType: thirdFunQuery)
        foursquareAPI.getChosenVenue(location, queryType: snackQuery)
        foursquareAPI.getChosenVenue(location, queryType: fourthFunQuery)
        foursquareAPI.getChosenVenue(location, queryType: dinnerQuery)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        //self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            
            //stop monitoring regions in locationManager
            for reg in locationManager.monitoredRegions{
                locationManager.stopMonitoringForRegion(reg)
            }
            
            
        }
        let geocoder = CLGeocoder()
        let foursquareAPI = VenueAPI(currDelegate: self)
        let address = inputtedAddress
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil) {
                print("error",error)
            }
            if let placemark = placemarks?.first {
                let coordinates = placemark.location!.coordinate
                let currLatitude = coordinates.latitude
                let currLongitude = coordinates.longitude
                let location = CLLocation(latitude: currLatitude, longitude: currLongitude)
                self.centerMapAtLocation(location)
                if(chosenMode == "Surprise me!")
                {
                    let arrayNumber = Int(arc4random_uniform(3))
                    var chosenArray = []
                    if(arrayNumber == 0)
                    {
                        chosenArray = foodQueryTypes
                    }
                    else if(arrayNumber == 1)
                    {
                        chosenArray = snackQueryTypes
                    }
                    else {
                        chosenArray = funQueryTypes
                    }
                    let randomIndex = Int(arc4random_uniform(UInt32(chosenArray.count)))
                    let givenQuery = chosenArray[randomIndex]
                    foursquareAPI.getChosenVenue(location, queryType: givenQuery as! String)
                }
                else if(chosenMode == "Half-day")
                {
                    self.executeHalfDay(foursquareAPI, location: location)
                }
                else
                {
                    self.executeFullDay(foursquareAPI, location: location)
                }
                
                
            }
        })
        //let firstPoint = Artwork(title: "Cathedral of Learning", discipline: "church", coordinate: CLLocationCoordinate2D(latitude: 40.444247, longitude: -79.953338))
        
        //mapView.addAnnotation(currentVenues.first!)
        //plotAnnotations(points)
        
        
      
    }
    let regionRadius: Double = 1000
    func centerMapAtLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }

    let locationManager = CLLocationManager()
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locValue = manager.location!.coordinate
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let alert = UIAlertController(title: "Congratulations!", message: "Check into: \(self.listVenues[currentVenueIndex].title!)", preferredStyle: .Alert)
        currentVenueIndex = (currentVenueIndex + 1) % self.listVenues.count
        let ok_action = UIAlertAction(title: "Get 100 Pearls", style: .Default) { (_) in
            print("ok")
        }
        alert.addAction(ok_action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //changes
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("here")
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("ugh")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }

}
