//
//  LoginView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 1/1/22.
//

import SwiftUI

struct LoginView: View {
    @State var show: Bool = false
    @State var viewState: CGSize = CGSize.zero
    @State var isDragging: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all) // back layer
            
            Color("background2").edgesIgnoringSafeArea(.bottom) // middle layer
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            VStack {                                                                        // top layer
                GeometryReader { geometry in                                                // wrap Text in a geometry reader
                    Text("Learn design & code.\nFrom scratch.")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))       // take screen size into account when displaying title fonts
                }
                .frame(maxWidth: 375, maxHeight: 100) // ideal max font size
                .padding(.horizontal, 16)
                .foregroundColor(Color("background1"))
                .offset(x: viewState.width / 15, y: viewState.height / 15)
                
                
                Text("80 hours of courses for SwiftUI, React, and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                    .foregroundColor(.primary)
                    .offset(x: viewState.width / 20, y: viewState.height / 20)
                
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {                                                                // build out two images, blobs in this instance
                    Image("Blob")
                        .offset(x: -150, y: -200)
                        .rotationEffect(Angle(degrees: show ? 360+90 : 90))             // added rotation effect, +90 so it doesnt skip
                        .blendMode(.plusDarker)
                        .onAppear {
                            self.show = true
                        }
                    Image("Blob")
                        .offset(x: -200, y: -50)
                        .blendMode(.overlay)
                        .rotationEffect(Angle(degrees: show ? 360+90 : 0), anchor: .topLeading)
                }
                    .animation(Animation.linear(duration: 40).repeatForever())    // animation for the zStack with both blobs, animating the rotation effect
            )
            .background(
                Image("Card3")
                    .offset(x: viewState.width / 20, y: viewState.height / 20)
                ,
                alignment: .bottom
            )
            .background(Color("card1"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDragging ? 0.8 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.isDragging = true
                        self.viewState = value.translation
                    }
                    .onEnded { value in
                        self.isDragging = false
                        self.viewState = .zero
                    }
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
