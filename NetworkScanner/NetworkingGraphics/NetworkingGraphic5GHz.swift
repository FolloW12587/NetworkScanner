//
//  NetworkingGraphic5GHz.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 28.03.2024.
//

import CoreWLAN
import SwiftUI

struct NetworkingGraphic5GHz: View {
    var channels: [Int] = {
        var output = Array(stride(from: 36, through: 64, by: 4))
        output.append(contentsOf: stride(from: 100, through: 144, by: 4))
        output.append(contentsOf: stride(from: 149, through: 161, by: 4))
        return output
    }()
    var maxChannelsOffset = 7
    var quarterChannelsCount: Int {
        maxChannelsOffset*4*2 + channels.last! - channels.first!
    }
    
    let networks: Set<CWNetwork>
    
    
    var body: some View {
        GeometryReader { proxy in
            Canvas { context, size in
                var path = Path()
                let topOffset = size.height*0.7
                let quarterChannelWidth = size.width / CGFloat(quarterChannelsCount)
                let standartChannelWidth = quarterChannelWidth * 4
                let sideOffset = standartChannelWidth * CGFloat(maxChannelsOffset)
                path.move(to: CGPoint(x: sideOffset, y: topOffset))
                path.addLine(to: CGPoint(x: size.width-sideOffset, y: topOffset))
                
                
                for channel in channels {
                    let channelNum = channel-channels.first!
                    var path = Path()
                    let xOffset = sideOffset + quarterChannelWidth*CGFloat(channelNum)
                    path.move(to: CGPoint(x: xOffset, y: topOffset-5))
                    path.addLine(to: CGPoint(x: xOffset, y: topOffset+5))
                    
                    context.stroke(path, with: .color(.black), lineWidth: 0.4)
                    context.draw(Text("\(channel)").font(.caption), at: CGPoint(x: xOffset, y: topOffset+20))
                }
//                
                context.stroke(path, with: .color(.black), lineWidth: 1)
                
                for network in networks {
                    guard let wlanChannel = network.wlanChannel else { continue }

                    let rssiValue = network.rssiValue
                    let channel = wlanChannel.channelNumber - channels.first!
                    let channelWidth = pow(2, CGFloat(wlanChannel.channelWidth.rawValue))

                    let frameWidth = quarterChannelWidth*channelWidth*2
                    let frameHeight = (100 + CGFloat(rssiValue)) / 40 * 100

                    let x = sideOffset + quarterChannelWidth*CGFloat(channel) - frameWidth*0.5
                    let y = topOffset-frameHeight
                    let frame = CGRect(x: x,
                                       y: y,
                                       width: frameWidth, height: frameHeight)

                    let trapezoid = Trapezoid().path(in: frame)

                    let color = Color(red: .random, green: .random, blue: .random)
                    context.fill(trapezoid, with: .color(color.opacity(0.5)))
                    context.stroke(trapezoid, with: .color(color), lineWidth: 2)

                    guard let ssid = network.ssid else { continue }
//                    print(ssid, wlanChannel.channelWidth.rawValue, channelWidth, wlanChannel.channelNumber)
                    context.draw(Text(ssid).foregroundStyle(color.opacity(0.5)), at: CGPoint(x: frame.midX, y: y-20))
                }
            }
//            .onAppear {
//                print(channels)
//            }
        }
    }
}

#Preview {
    NetworkingGraphic5GHz(networks: [])
}
