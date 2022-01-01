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
    
    let backgroundColor: CGColor = #colorLiteral(red: 0.7890059352, green: 0.8985413909, blue: 0.9454202056, alpha: 1)
    
    var body: some View {
        VStack(spacing: 50) {
            RectangeButton()
            CircleButton()
            PayButton()
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

struct RectangeButton: View {
    
    @State var tap: Bool = false
    @State var press: Bool = false
    
    let white: CGColor = #colorLiteral(red: 1, green: 1, blue: 0.9999999404, alpha: 1)
    let blue: CGColor = #colorLiteral(red: 0.7549576163, green: 0.8167447448, blue: 0.9200447202, alpha: 1)
    let iconColor: CGColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
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
}

struct CircleButton: View {
    
    @State var tap: Bool = false
    @State var press: Bool = false
    
    let white: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let blue: CGColor = #colorLiteral(red: 0.7549576163, green: 0.8167447448, blue: 0.9200447202, alpha: 1)
    let backgroundColor: CGColor = #colorLiteral(red: 0.7890059352, green: 0.8985413909, blue: 0.9454202056, alpha: 1)
    
    var body: some View {
        ZStack {
            // sunmax is the default state, when we long press on this
            // component it should move sunmax to the top left and move
            // the moon into the center from the bottom right
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .scaleEffect(press ? 0.1 : 1)
                .offset(x: press ? -90 : 0, y: press ? -90 : 0) // on long press we move the icon to the top right, it disspears due to the clipShape modifier
                .rotation3DEffect(Angle(degrees: press ? 20: 0), axis: (x: 10, y: -10, z: 0))
            
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .scaleEffect(press ? 1 : 0.1)
                .offset(x: press ? 0 : 90, y: press ? 0 : 90) // on long press we move the icon to the top right, it disspears due to the clipShape modifier
                .rotation3DEffect(Angle(degrees: press ? 0 : 20), axis: (x: 10, y: -10, z: 0))
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: press ? [Color(backgroundColor), Color(white)] : [Color(white), Color(backgroundColor)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Circle()
                    .stroke(Color(press ? white : blue) ,lineWidth: 10)
                    .blur(radius: 4)
                    .offset(x: -5, y: -5)
                
                Circle()
                    .stroke(Color(press ? blue : white), lineWidth: 5)
                    .blur(radius: 4)
                    .offset(x: 5, y:5)
            }
        )
        .clipShape(Circle())
        .shadow(color: Color(press ? blue : white), radius: 20, x: -20, y: -20) // set shadow to top left
        .shadow(color: Color(press ? white : blue), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture()
                .onChanged { value in
                    self.tap = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                    }
                }
            
                .onEnded { value in
                    self.press.toggle()
                }
        )
    }
}

struct PayButton: View {
    
    @GestureState var tap: Bool = false
    @State var press: Bool = false
    
    let white: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let blue: CGColor = #colorLiteral(red: 0.7549576163, green: 0.8167447448, blue: 0.9200447202, alpha: 1)
    let backgroundColor: CGColor = #colorLiteral(red: 0.7890059352, green: 0.8985413909, blue: 0.9454202056, alpha: 1)
    
    var body: some View {
        
        // three images here in a z stack
        // the first sets in the background
        // fades out and scales down on longpress
        
        // the second sets in the middle
        // as you long press it starts to animate up in front of the last image
        // you cant see it move in to frame until the finger print image
        // due to the clipShape rectangle
        // this fades out and scales down on longpress
        
        // the third image is a finished check mark
        // fades in and scales up on longpress
        
        ZStack {
            Image("fingerprint")
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(
                    Rectangle()
                        .offset(y: tap ? 0 : 50)
                )
                .animation(.easeInOut)
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                    .mask(
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 34, weight: .light))
                            .foregroundColor(.white)
                            .opacity(press ? 1 : 0)
                            .scaleEffect(press ? 1 : 0)
                            .animation(.easeInOut)
                    )
        }
        .frame(width: 120, height: 120)
        .background(
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: press ? [Color(backgroundColor), Color(white)] : [Color(white), Color(backgroundColor)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Circle()
                    .stroke(Color(press ? white : blue) ,lineWidth: 10)
                    .blur(radius: 4)
                    .offset(x: -5, y: -5)
                
                Circle()
                    .stroke(Color(press ? blue : white), lineWidth: 5)
                    .blur(radius: 4)
                    .offset(x: 5, y:5)
            }
        )
        .clipShape(Circle())
        .overlay(
            Circle()
                .trim(from: tap ? 0.001 : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .frame(width: 88, height: 88)
                .shadow(color: .purple, radius: 3, x: -3, y: -5)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .animation(.easeInOut)
        )
        .shadow(color: Color(press ? blue : white), radius: 20, x: -20, y: -20) // set shadow to top left
        .shadow(color: Color(press ? white : blue), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture()
                .updating($tap) { currentState, gestureState, transaction in
                    gestureState = currentState
                }
                .onEnded { value in
                    self.press.toggle()
                }
        )
    }
}
