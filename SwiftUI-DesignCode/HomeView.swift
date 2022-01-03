//
//  HomeView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/29/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var store = CourseStore()
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    @Binding var viewState: CGSize
    
    @State var showUpdate: Bool = false
    @State var active: Bool = false
    @State var activeIndex: Int = -1

    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
                VStack {
                    HStack {
                        Text("Watching")
                          .modifier(CustomFontModifier())

                        Spacer()
                        
                        AvatarView(showProfile: $showProfile)
                        
                        Button(action: {
                            self.showUpdate.toggle()
                        }) {
                            Image(systemName: "bell")
                                .foregroundColor(.primary) // primary and secondary are best for textual content, when usingn dark/light theme
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 36, height: 36)
                                .background(Color("background3"))
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
                        HStack(spacing: 20) {
                            ForEach(sectionData) { section in
                                GeometryReader { geometry in
                                    SectionView(section: section)
                                        .rotation3DEffect(
                                            Angle(degrees: Double(geometry.frame(in: .global).minX) / -getAngleMultiplier(bounds:bounds)),
                                                        axis: (x: 0, y: 100, z: 0))
                                }
                                .frame(width: 275, height: 275)
                            }
                        }
                        .padding(30)
                        .padding(.bottom, 30)
                    }
                    .offset(y: -30)
                    

                    
                    VStack(spacing: 30) {
                        Text("Courses")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .blur(radius: self.active ? 20 : 0)
                        
                        ForEach(store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CourseView(
                                    show: $store.courses[index].show,
                                    active: $active,
                                    activeIndex: $activeIndex,
                                    index: index,
                                    course: store.courses[index],
                                    bounds: bounds
                                )
                                .offset(y: store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(activeIndex != index && active ? 0 : 1)
                                .scaleEffect(activeIndex != index && active ? 0 : 1)
                                .offset(x: activeIndex != index && active ? bounds.size.width : 0)
                            }
                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: store.courses[index].show ? 712 : getCardWidth(bounds: bounds), alignment: .center)
                            .zIndex(store.courses[index].show ? 1 : 0)
                        }
                    }
                    .padding(.bottom, 300)
                    .offset(y: -60)
                    
                    Spacer()
                }
                .frame(width: bounds.size.width)
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

func getAngleMultiplier(bounds: GeometryProxy) -> Double {
    if bounds.size.width > 500 {
        return 80
    }
    
    return 30
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            showProfile: .constant(false),
            showContent: .constant(false),
            viewState: .constant(CGSize.zero)
        )
            .preferredColorScheme(.dark)
            .environmentObject(UserStore())
.previewInterfaceOrientation(.portrait)
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
            .background(Color("background3"))
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
            .background(Color("background3"))
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
            .background(Color("background3"))
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
            .background(Color("background3"))
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
            .background(Color("background3"))   
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
