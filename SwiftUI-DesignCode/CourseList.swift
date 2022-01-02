//
//  CourseList.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/30/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var store = CourseStore()
    
    @State var active: Bool = false
    @State var activeIndex: Int = -1
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.black.opacity(self.active ? 0.5 : 0)
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
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
}

func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width > 712 {
        return 712
    }
    return bounds.size.width - 60
}

func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    
    print("HIT <<<<<", bounds.size.width < 712, bounds.safeAreaInsets.top < 44, "HIT<<<")
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 { // if screen is not small and doesn't have a notch
        return 0
    }
    return 30
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList().preferredColorScheme(.dark).previewInterfaceOrientation(.portrait)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: Image
    var logo: Image
    var color: Color
    var show: Bool
}

var courseData = [
    Course(
        title: "Prototype Designs in SwiftUI",
        subtitle: "18 Sections",
        image: Image("Card1"),
        logo: Image("Logo2"),
        color: .blue,
        show: false
    ),
    Course(
        title: "SwiftUI Advanced",
        subtitle: "20 Sections",
        image: Image("Card2"),
        logo: Image("Logo1"),
        color: .red,
        show: false
    ),
    Course(
        title: "UI Design for Developers",
        subtitle: "23 Sections",
        image: Image("Card3"),
        logo: Image("Logo3"),
        color: .green,
        show: false
    )
]

struct CourseView: View {
    
    @State var activeView: CGSize = CGSize.zero
    
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var index: Int
    var course: Course
    var bounds: GeometryProxy
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Take you SwiftUI App to the app Store with advanced techniques like API data, packages and CMS")

                Text("About this course")
                    .font(.title).bold()

                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and buildg real apps for Ios and macOS. While it's not on codebase for all apps, you learn once and can apply the techniques and crontrols to all platforms with incredible quality, consistency  and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")

                Text("Minial coding experience required, such as in HTML and CSS. Please not tht Xcode 11 and Catalina are essential. Once you get everthing installed, it'll get a lot freindlier! I added a bunch of troubleshoots at the end if this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : bounds.size.width, maxHeight: show ? .infinity : 380 )
            .offset(y: show ? 460 : 0)
            .background(Color("background2"))
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        course.logo
                            .opacity(show ? 0 : 1)
                        Image(systemName: "xmark")
                            .frame(width: 40, height: 40)
                            .background(.black)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                course.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : bounds.size.width, maxHeight: show ? 460 : 280)
            .background(course.color)
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color.purple.opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                show.toggle()
                active.toggle()
                
                if show {
                    activeIndex = index
                } else {
                    activeIndex = -1
                }
            }
        }
        .frame(width: .infinity, height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        .contentShape(Rectangle())
        .scaleEffect(1 - activeView.height / 100)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.2))
        .edgesIgnoringSafeArea(.all)
    }
}

