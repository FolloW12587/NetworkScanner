//
//  LocationDataManager.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 27.03.2024.
//

import CoreLocation

@MainActor
class LocationDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationDataManager()
    
    // Create a location manager.
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        // Configure the location manager.
        locationManager.delegate = self
    }
    
    // Location-related properties and methods.
    
    func requestAccess() {
        switch locationManager.authorizationStatus {


            // If authorized, start location services.
        case .authorizedWhenInUse:
//            print("authorized")
            break

            // Request authorization if the user hasn't chosen whether your app
            // can use location services yet.
        case .notDetermined:
//            print("authorizing")
            locationManager.requestWhenInUseAuthorization()


        case .denied, .restricted:
            // Handle denied or restricted status.
            print("restricted")
//            break
        default:
            print("unknown \(locationManager.authorizationStatus)")
//            break
        }
    }
}
