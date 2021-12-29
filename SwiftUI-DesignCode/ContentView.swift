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
    @State private var showCard: Bool = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.2 : 1)
                .offset(x: 0, y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
                )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340.0, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height )
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0 : 12))
                .rotationEffect(.degrees(showCard ? -12 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (
                    x: 10.0, y: 0, z: 0
                ))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.4))

            BackCardView()
                .frame(width: showCard ? 375 : 340.0, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -30)
                .offset(x: viewState.width, y: viewState.height )
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (
                    x: 10.0, y: 0, z: 0
                ))
                .blendMode(.hardLight)

            CardView()
                .frame(width: showCard ? 375 : 340, height: 220)
                .background(.black)
                .clipShape(
                    RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous)
                )
                .shadow(radius: 20)
                .blendMode(.hardLight)
                .offset(x: viewState.width, y: viewState.height )
                .offset(x: 0, y: showCard ? -100 : 0)
                .onTapGesture {
                    showCard.toggle()
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
                .offset(x: 0, y: showCard ? 360 : 1000 )
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
    
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
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }

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
    }
}
