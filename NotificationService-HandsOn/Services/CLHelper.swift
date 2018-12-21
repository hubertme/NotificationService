//
//  CLHelper.swift
//  NotificationService-HandsOn
//
//  Created by Hubert Wang on 21/12/18.
//  Copyright © 2018 Hubert Wang. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class CLHelper: NSObject {
    
    private override init() {}
    static let shared = CLHelper()
    
    let locationManager = CLLocationManager()
    var shouldSetRegion = true
    
    func authorize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
    
}

extension CLHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location")
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("DID ENTER REGION VIA CL")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"),
                                        object: nil)
    }
}
