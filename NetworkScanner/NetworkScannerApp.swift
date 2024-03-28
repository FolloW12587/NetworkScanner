//
//  NetworkScannerApp.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 24.03.2024.
//

import SwiftUI
import CoreLocation

@main
struct NetworkScannerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
//        let locationManager = CLLocationManager()
//        
//        switch locationManager.authorizationStatus {
//
//
//            // If authorized, start location services.
//        case .authorizedWhenInUse:
//            print("authorized")
//
//
//            // Request authorization if the user hasn't chosen whether your app
//            // can use location services yet.
//        case .notDetermined:
//            print("authorizing")
//            locationManager.requestWhenInUseAuthorization()
//
//
//        case .denied, .restricted:
//            // Handle denied or restricted status.
//            print("restricted")
////            break
//        default:
//            print("unknown \(locationManager.authorizationStatus)")
////            break
//        }
    }
}
