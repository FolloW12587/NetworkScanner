//
//  NetworkDiscovery.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 24.03.2024.
//

import Foundation
import CoreWLAN

class NetworkDiscovery: ObservableObject {
    @Published var currentInterface: CWInterface?
    @Published var networks: Set<CWNetwork> = []

    init() {
        guard let defaultInterface = CWWiFiClient.shared().interface() else {
            print("Can't find default networ interface")
            return
        }
        self.currentInterface = defaultInterface
        self.findNetworks(useCache: true)
    }

    // Init with the literal interface name, like "en1"
    init(interfaceWithName name: String) {
        guard let interface = CWWiFiClient.shared().interface(withName: name) else {
            print("Can't find interface with name \(name)")
            return
        }
        self.currentInterface = interface
        self.findNetworks(useCache: true)
    }

    // Fetch detectable WIFI networks
    func findNetworks(useCache: Bool = false) {
        guard let currentInterface else { return }
        if useCache {
            if let networks = currentInterface.cachedScanResults() {
                self.networks = networks
                return
            }
        }
        do {
            self.networks = try currentInterface.scanForNetworks(withSSID: nil, includeHidden: true)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }

}
