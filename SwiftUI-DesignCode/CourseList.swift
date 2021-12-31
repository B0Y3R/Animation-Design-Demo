//
//  CourseList.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/30/21.
//

import SwiftUI

struct CourseList: View {
    @State var courses = courseData
    @State var active: Bool = false
    @State var activeIndex: Int = -1
    
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
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
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show: $courses[index].show,
                                active: $active,
                                activeIndex: $activeIndex,
                                index: index,
                                course: courses[index]
                            )
                            .offset(y: courses[index].show ? -geometry.frame(in: .global).minY : 0)
                            .opacity(activeIndex != index && active ? 0 : 1)
                            .scaleEffect(activeIndex != index && active ? 0 : 1)
                            .offset(x: activeIndex != index && active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: courses[index].show ? .infinity : screen.width - 60, alignment: .center)
                        .zIndex(courses[index].show ? 1 : 0)
                    }

                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: Image
    var logo: Image
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: Image("Card1"), logo: Image("Logo2"), color: .blue, show: false),
    Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: Image("Card2"), logo: Image("Logo1"), color: .red, show: false),
    Course(title: "UI Design for Developers", subtitle: "23 Sections", image: Image("Card3"), logo: Image("Logo3"), color: .green, show: false)
]

struct CourseView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var index: Int
    var course: Course
    
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
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280 )
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
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
                    .aspectRatio(contentMode:.fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
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
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.2))
        .edgesIgnoringSafeArea(.all)
    }
}

