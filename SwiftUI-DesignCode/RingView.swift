//
//  RingView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/30/21.
//

import SwiftUI

struct RingView: View {
    
    var color1: Color = Color.red
    var color2: Color = Color.orange
    var size: CGFloat = 60
    var percent: CGFloat = 88.0
    
    var body: some View {
        
        let multiplier = size / 44
        let progress = (100 - percent) / 100
        
        return ZStack {
            Circle()
                .stroke(
                    Color.black.opacity(0.1),
                    style: StrokeStyle(lineWidth: 5 * multiplier)
                )
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: progress, to: 1)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [color1, color2]),
                        startPoint: .topTrailing,
                        endPoint: .topLeading
                    ),
                    style: StrokeStyle(
                        lineWidth: 5 * multiplier,
                        lineCap: .round,
                        lineJoin: .round,
                        miterLimit: .infinity,
                        dash: [20, 0],
                        dashPhase: 0
                    )
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1, y:0, z: 0)
                )
                .frame(width: size, height: size)
                .shadow(
                    color: color1.opacity(0.8),
                    radius: 3 * multiplier, x: 0, y: 3 * multiplier
                )
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
