//
//  HomeView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/29/21.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    
    @State var showUpdate: Bool = false

    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                      .modifier(CustomFontModifier())

                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: {
                        showUpdate.toggle()
                    }) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                    
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 25)
                        .onTapGesture {
                            showContent = true
                        }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(sectionData) { section in
                            GeometryReader { geometry in
                                SectionView(section: section)
                                    .rotation3DEffect(
                                        Angle(
                                            degrees: Double(geometry.frame(in: .global).minX - 30) / 10),
                                        axis: (x: 0, y: -200, z: 0)
                                    )
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title)
                    .bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(
                    section: sectionData[2],
                    width: screen.width - 60
                )
                .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(
        title: "Prototype Designs in SwiftUI",
        text: "18 Sections",
        logo: "Logo1",
        image: Image("Card1"),
        color: Color("card1")
    ),
    Section(
        title: "Build a SwiftUi App",
        text: "8 Sections",
        logo: "Logo1",
        image: Image("Card2"),
        color: Color("card2")
    ),
    Section(
        title: "SwiftUI Advanced",
        text: "18 Sections",
        logo: "Logo1",
        image: Image("Card3"),
        color: Color("card3")
    ),
    Section(
        title: "Testing with SwiftUI",
        text: "18 Sections",
        logo: "Logo1",
        image: Image("Card4"),
        color: Color("card4")
    )
];

struct SectionView: View {
    
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.5), radius: 20, x: 0, y: 20)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
            .preferredColorScheme(.light)
    }
}


struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(
                    show: .constant(true),
                    color1: Color.purple,
                    color2: Color.pink,
                    size: 44,
                    percent: 23,
                    progressDuration: 0.1
                )
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(
                    show: .constant(true),
                    size: 44,
                    percent: 90,
                    progressDuration: 0.1
                )
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(
                    show: .constant(true),
                    color1: Color.green,
                    color2: Color.blue,
                    size: 44,
                    percent: 44,
                    progressDuration: 0.1
                )
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                RingView(
                    show: .constant(true),
                    color1: Color.orange,
                    color2: Color.red,
                    size: 44,
                    percent: 83,
                    progressDuration: 0.1
                )
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(
                    show: .constant(true),
                    color1: Color.yellow,
                    color2: Color.green,
                    size: 44,
                    percent: 83,
                    progressDuration: 0.1
                )
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            
        }
    }
}
