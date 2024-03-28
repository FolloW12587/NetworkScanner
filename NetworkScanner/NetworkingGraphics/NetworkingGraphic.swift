//
//  NetworkingGraphic.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 27.03.2024.
//

import SwiftUI
import CoreWLAN

struct NetworkingGraphic: View {
    let networks: Set<CWNetwork>
    let currentBand: CWChannelBand
    
    var body: some View {
        if currentBand == .band2GHz {
            NetworkingGraphic2GHz(networks: networks)
        } else {
            NetworkingGraphic5GHz(networks: networks)
        }
    }
}

#Preview {
    NetworkingGraphic(networks: [], currentBand: .band2GHz)
}
