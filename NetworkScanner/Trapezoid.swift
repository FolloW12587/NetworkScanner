//
//  Trapezoid.swift
//  NetworkScanner
//
//  Created by Сергей Дубовой on 27.03.2024.
//

import SwiftUI


struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        let x = rect.origin.x
        let y = rect.origin.y
        let sideOffset = min(20, rect.size.width*0.2)
        
        var path = Path()
        
        path.move(to: CGPoint(x: x, y: y+rect.size.height))
        path.addLine(to: CGPoint(x: x+sideOffset, y: y))
        path.addLine(to: CGPoint(x: x+rect.size.width-sideOffset, y: y))
        path.addLine(to: CGPoint(x: x+rect.size.width, y: y+rect.height))
        
        return path
    }
}


#Preview {
    Trapezoid()
        .stroke(.red)
        .frame(width: 200, height: 100)
        
}
