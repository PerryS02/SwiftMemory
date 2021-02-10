//
//  Pie.swift
//  Test
//
//  Created by Perry Sykes on 2/3/21.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * cos(CGFloat(startAngle.radians))
        )
        var emptyPath = Path()
        emptyPath.move(to: center)
        emptyPath.addLine(to: start)
        emptyPath.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        emptyPath.addLine(to: center)
        return emptyPath
    }
}
