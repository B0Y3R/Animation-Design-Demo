//
//  ContentView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/28/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var show: Bool = false
    @State private var viewState: CGSize = CGSize.zero
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
            
            BackCardView(
                color: show ? Color("card3") : Color("card4"),
                offsetY: show ? -400 : -40,
                rotationDegrees: show ? 0 : 12,
                rotation3dDegrees: 10
            )
                .offset(x: viewState.width, y: viewState.height )
                .animation(.easeInOut(duration: 0.4))

            BackCardView(
                color: show ? Color("card4") : Color("card3"),
                offsetY: show ? -200 : -30,
                rotationDegrees: show ? 0 : 5 ,
                rotation3dDegrees: 5
            )
                .offset(x: viewState.width, y: viewState.height )

            CardView()
                .offset(x: viewState.width, y: viewState.height )
                .onTapGesture {
                    show.toggle()
                }
                .animation(
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.5,
                        blendDuration: 0.9
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            viewState = value.translation
                        }
                        .onEnded({ value in
                            viewState = .zero
                        })
                )
            
            BottomCardView()
                .blur(radius: show ? 20 : 0)
        }
        .animation(.easeInOut(duration: 0.35))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            
            Image("Background1")
            Spacer()
        }
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
            
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
        .frame(width: 340, height: 220)
        .background(.black)
        .cornerRadius(20)
        .shadow(radius: 20)
        .blendMode(.hardLight)
    }
}

struct BackCardView: View {
    var color: Color
    var offsetY: CGFloat
    var rotationDegrees: Double
    var rotation3dDegrees: Double

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(width: 340.0, height: 220)
        .background(color)
        .cornerRadius(20)
        .shadow(radius: 20)
        .offset(x: 0, y: offsetY)
        .scaleEffect(0.9)
        .rotationEffect(.degrees(rotationDegrees))
        .rotation3DEffect(Angle(degrees: rotation3dDegrees), axis: (
            x: 10.0, y: 0, z: 0
        ))
        .blendMode(.hardLight)
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 40, height: 4)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("This certificate is proof that James Boyer has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: 750)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .offset(x: 0, y: 500)
    }
}
