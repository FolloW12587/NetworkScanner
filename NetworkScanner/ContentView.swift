//
//  ContentView.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 24.03.2024.
//

import CoreWLAN
import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var nd = NetworkDiscovery()
    
    @State var currentBand: CWChannelBand = .band2GHz
    
    var filteredNetworks: Set<CWNetwork> {
        nd.networks.filter { network in
            network.wlanChannel?.channelBand == currentBand
        }
    }
    
    var body: some View {
        VStack {
            Text("Network Analizer")
                .font(.title)
            
            Text("Current band is \(currentBand == .band2GHz ? "2.4Ghz" : "5Ghz")")
            
            
            NetworkingGraphic(networks: filteredNetworks, currentBand: currentBand)
            
            Button {
                currentBand = currentBand == .band2GHz ? .band5GHz : .band2GHz
            } label: {
                Text("Switch band")
            }
            
            Button {
                withAnimation {
                    nd.findNetworks()
                }
            } label: {
                Text("refresh")
            }

            
        }
        .padding()
        .frame(minWidth: 1000, minHeight: 400)
        .onAppear {
            LocationDataManager.shared.requestAccess()
        }
    }
    
}

#Preview {
    ContentView()
}
