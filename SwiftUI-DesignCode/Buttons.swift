//
//  Buttons.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 1/1/22.
//

import SwiftUI

// were going for neumorphic buttons here
// lots of inner shadow practice

struct Buttons: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    
                    // nest in zStack were going to be building layers to produce the inner shadow
                    ZStack {
                        Color(.gray).opacity(0.01)
                        
                        // draw a new rectangle on top excatly the same shape as the button above
                        // this creates a white layer on top of the button
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(.white) // set the color
                            .blur(radius: 4) // this sets the blur on the inside edges
                            .offset(x: -8, y: -8) // pulls this layer up to the top left
                        
                        
                        // draw another rectangle
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8991510272, green: 0.9244170785, blue: 0.9885553718, alpha: 1)), Color(.white)] ),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            ) // instead of setting foreground color here, we'll fill the rectangle with a Linear Gradient
                            .padding(2) // little padding to pull layer from outer edges
                            .blur(radius: 2) // and some blur so the layers aren't super visible
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color(.blue).opacity(0.25),  radius: 20, x: 20, y: 20)
                .shadow(color: Color(.white), radius: 20, x: -20, y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(#colorLiteral(red: 0.9016503096, green: 0.9350115657, blue: 0.9987991452, alpha: 1)))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
