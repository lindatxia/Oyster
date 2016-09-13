//
//  VCMapView.swift
//  Expl0r
//
//  Created by Raunak Gupta on 10/9/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import Foundation
import MapKit

extension MapController: MKMapViewDelegate {
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
                 calloutAccessoryControlTapped control: UIControl!) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
}
