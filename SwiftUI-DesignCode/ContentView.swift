//
//  ContentView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/28/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewState: CGSize = CGSize.zero
    @State var showCard: Bool = false
    @State var bottomCardState: CGSize = CGSize.zero
    @State var showFull: Bool = false
    
    var body: some View {
        ZStack {
            TitleView(showCard: showCard)
            
            BackCardView()
                .frame(maxWidth: showCard ? 300 : 340.0)
                .frame(height: 220)
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: -10, y: -50)
                .offset(x: viewState.width, y: viewState.height )
                .offset(y: showCard ? -160 : 0)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(12))
                .rotationEffect(.degrees(showCard ? -12 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (
                    x: 10.0, y: 0, z: 0
                ))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.4))

            BackCardView()
                .frame(maxWidth: showCard ? 350 : 340.0)
                .frame(height: 220)
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: -10, y: -30)
                .offset(x: viewState.width, y: viewState.height )
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (
                    x: 10.0, y: 0, z: 0
                ))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))

            CardView(showCard: showCard, viewState: viewState)
                .onTapGesture {
                    showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            viewState = value.translation
                        }
                        .onEnded({ value in
                            viewState = .zero
                        })
                )
            
            GeometryReader { bounds in
                BottomCardView(show: $showCard )
                    .offset(x: 0, y: self.showCard ? bounds.size.height / 2 : bounds.size.height )
                    .offset(y: self.bottomCardState.height)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.bottomCardState = value.translation
                                
                                if self.showFull {
                                    self.bottomCardState.height += -300
                                }
                                
                                if self.bottomCardState.height < -300 {
                                    self.bottomCardState.height = -300
                                }

                            }
                            .onEnded { value in
                                if self.bottomCardState.height > 100 {
                                    self.showCard = false
                                }
                                
                                if (self.bottomCardState.height < -100 && !self.showFull) || (self.bottomCardState.height < -250 && self.showFull) {
                                    self.showFull = true
                                    self.bottomCardState.height = -300
                                } else {
                                    self.bottomCardState = .zero
                                    self.showFull = false
                                }
                            }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 320, height: 667))
    }
}

struct TitleView: View {
    
    var showCard: Bool
    
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
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 375)
            Spacer()
        }
        .opacity(showCard ? 0.2 : 1)
        .offset(x: 0, y: showCard ? -200 : 0)
        .animation(
            Animation
                .default
                .delay(0.1)
        )
    }
}

struct CardView: View {
    
    var showCard: Bool
    var viewState: CGSize
    
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
        .frame(maxWidth: showCard ? 375 : 340)
        .frame(height: 220)
        .background(.black)
        .clipShape(
            RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous)
        )
        .shadow(radius: 20)
        .blendMode(.hardLight)
        .offset(x: viewState.width, y: viewState.height )
        .offset(x: 0, y: showCard ? -100 : 0)
        .animation(
            .spring(
                response: 0.5,
                dampingFraction: 0.5,
                blendDuration: 0.9
            )
        )
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
    
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 4)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("VINNY IS AN AGENT OF CHAOS")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20) {
                RingView(
                    show: $show,
                    size: 88,
                    percent: 90
                )
                
                VStack {
                    Text("SwiftUI")
                    Text("12 of 12 sections completed\n10 hours spent so far")
                        .font(.footnote )
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                
            }
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: 712)
        .background(BlurView(style: .systemUltraThinMaterial)) // system material will help you with dark mode / light mode
        .cornerRadius(30)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity)
    }
}
