//
//  NetworkingGraphic2GHz.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 28.03.2024.
//

import SwiftUI
import CoreWLAN

struct NetworkingGraphic2GHz: View {
    let channelsCount = 13
    let channelsOneSideMaxOffset = 4
    
    var segmentsCount: Int {
        channelsCount + channelsOneSideMaxOffset*2 - 1
    }
    
    let networks: Set<CWNetwork>
    
    
    var body: some View {
        GeometryReader { proxy in
            Canvas { context, size in
                // drawing channels line
                var path = Path()
                let segmentWidth = proxy.size.width / CGFloat(segmentsCount)
                let topOffset = size.height*0.7
                path.move(to: CGPoint(x: segmentWidth*CGFloat(channelsOneSideMaxOffset), y: topOffset))
                path.addLine(to: CGPoint(x: segmentWidth*CGFloat(channelsCount+channelsOneSideMaxOffset-1), y: topOffset))
                
                // drawing channels
                for channel in 1...channelsCount {
                    var path = Path()
                    let xOffset = segmentWidth*CGFloat(channelsOneSideMaxOffset + channel - 1)
                    path.move(to: CGPoint(x: xOffset, y: topOffset-5))
                    path.addLine(to: CGPoint(x: xOffset, y: topOffset+5))
                    context.stroke(path, with: .color(.black), lineWidth: 0.4)
                    
                    context.draw(Text("\(channel)"), at: CGPoint(x: xOffset, y: topOffset+20))
                }
                
                context.stroke(path, with: .color(.black), lineWidth: 1)
                
                // drawing networks
                for network in networks {
                    guard let wlanChannel = network.wlanChannel else { continue }
                    let rssiValue = network.rssiValue
                    let channel = wlanChannel.channelNumber
                    let channelWidth = pow(2, CGFloat(wlanChannel.channelWidth.rawValue))*2
                    
                    let frameWidth = segmentWidth*channelWidth
                    let frameHeight = (100 + CGFloat(rssiValue)) / 40 * 100
                    
                    let x = segmentWidth*CGFloat(channelsOneSideMaxOffset + channel - 1-Int(channelWidth/2))
                    let y = topOffset-frameHeight
                    let frame = CGRect(x: x,
                                       y: y,
                                       width: frameWidth, height: frameHeight)
                    
                    let trapezoid = Trapezoid().path(in: frame)
                    
                    let color = Color(red: .random, green: .random, blue: .random)
                    context.fill(trapezoid, with: .color(color.opacity(0.5)))
                    context.stroke(trapezoid, with: .color(color), lineWidth: 2)
                    
                    guard let ssid = network.ssid else { continue }
                    context.draw(Text(ssid).foregroundStyle(color.opacity(0.5)), at: CGPoint(x: frame.midX, y: y-20))
                }
            }
        }
    }
}

#Preview {
    NetworkingGraphic2GHz(networks: [])
}
