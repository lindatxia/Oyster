//
//  AnnotationAPI.swift
//  Expl0r
//
//  Created by Linda Xia on 9/10/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let region: CLCircularRegion
    
    init(title: String, discipline: String, coordinate: CLLocationCoordinate2D, region: CLCircularRegion)
    {
        self.title = title
        self.discipline = discipline
        self.coordinate = coordinate
        self.region = region
        
        super.init()
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): title!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}