//
//  Home.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/29/21.
//

import SwiftUI

struct Home: View {
    
    @State var showProfile: Bool = false
    @State var viewState: CGSize = CGSize.zero
    @State var showContent: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
                .background(
                    VStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color("background2"), Color.white]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.white)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(x: 0, y: showProfile ? -450 : 0)
                .rotation3DEffect(
                    Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0),
                    axis: (x: 10.0, y: 0, z: 0)
                )
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.6,
                        blendDuration: 0
                    )
                )
                .edgesIgnoringSafeArea(.all)
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.6,
                        blendDuration: 0
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            viewState = value.translation
                        }
                        .onEnded {value in
                            if viewState.height > 50 {
                                showProfile = false
                            }
                            viewState = .zero
                        }
                )
            
            if showContent {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                ContentView()
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width:36, height: 36)
                            .foregroundColor(.white)
                            .background(.black)
                        .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    showContent = false
                }
            }
    
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: { showProfile.toggle() }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds
// lets you detect the dimension of the screen, and by declaring out side of the scope i can use everywhere throughout the app
