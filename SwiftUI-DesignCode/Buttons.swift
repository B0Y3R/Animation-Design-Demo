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
    
    @State var tap: Bool = false
    @State var press: Bool = false
    
    let white: CGColor = #colorLiteral(red: 1, green: 1, blue: 0.9999999404, alpha: 1)
    let blue: CGColor = #colorLiteral(red: 0.7549576163, green: 0.8167447448, blue: 0.9200447202, alpha: 1)
    let backgroundColor: CGColor = #colorLiteral(red: 0.9016503096, green: 0.9350115657, blue: 0.9998994452, alpha: 1)
    let iconColor: CGColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    
    
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    
                    // nest in zStack were going to be building layers to produce the inner shadow
                    ZStack {
                        Color(press ? white : blue)
                        
                        // draw a new rectangle on top excatly the same shape as the button above
                        // this creates a white layer on top of the button
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color(press ? blue : white)) // set the color
                            .blur(radius: 4) // this sets the blur on the inside edges
                            .offset(x: -8, y: -8) // pulls this layer up to the top left
                        
                        
                        // draw another rectangle
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(white), Color(blue)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            ) // instead of setting foreground color here, we'll fill the rectangle with a Linear Gradient
                            .padding(2) // little padding to pull layer from outer edges
                            .blur(radius: 2) // and some blur so the layers aren't super visible
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    // overlay is like .background, except its going to float outside of the box instead being clipped
                    HStack { // HStack to push the icon to the right when usings a spacer
                        Image(systemName: "person.crop.circle")     // sficons
                            .font(.system(size: 24, weight: .light)) // need to use font on images with sf icon for styling size
                            .foregroundColor(Color.white.opacity( press ? 0 : 1)) // same thing here font styling
                            .frame(width: press ? 64 : 54, height: press ? 4 : 50)
                            .background(Color(iconColor))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(iconColor).opacity(0.3), radius: 10, x: 10, y: 10)
                            .offset(x: press ? 70 : -20, y: press ? 16 : 0) // using offset to pull it more to the left
                            Spacer()
                    }
                )
                .shadow(color: press ? Color(white) : Color(blue),  radius: 20, x: 20, y: 20)
                .shadow(color: press ? Color(blue) : Color(white), radius: 20, x: -20, y: -20)
                .scaleEffect(tap ? 1.2 : 1) // here we're adding a scale effect for our "tap" state
                .gesture(
                    LongPressGesture(minimumDuration: 0.5, maximumDistance: 10) // we define a long press guesture and have it watch with onChanged
                        .onChanged { value in
                            self.tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // make the animation delay before changing state again
                                self.tap = false
                            }
                        }
                    
                        .onEnded { value in
                            self.press.toggle()
                        }
                 )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        .background(Color(backgroundColor))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
