//
//  CourseDetail.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/30/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var body: some View {
        ScrollView {
            VStack {
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
                            Image(systemName: "xmark")
                                .frame(width: 40, height: 40)
                                .background(.black)
                                .foregroundColor(.primary)
                                .clipShape(Circle())
                                .onTapGesture {
                                    show = false
                                    active = false
                                    activeIndex = -1
                                }
                        }
                    }
                    Spacer()
                    WebImage(url: course.image)
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(show ? 30 : 20)
                .padding(.top, show ? 30 : 0)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(course.color)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.purple.opacity(0.3), radius: 20, x: 0, y: 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Take you SwiftUI App to the app Store with advanced techniques like API data, packages and CMS")
                    
                    Text("About this course")
                        .font(.title).bold()
                    
                    Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and buildg real apps for Ios and macOS. While it's not on codebase for all apps, you learn once and can apply the techniques and crontrols to all platforms with incredible quality, consistency  and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                    
                    Text("Minial coding experience required, such as in HTML and CSS. Please not tht Xcode 11 and Catalina are essential. Once you get everthing installed, it'll get a lot freindlier! I added a bunch of troubleshoots at the end if this page to help you navigate the issues you might encounter.")
                }
                .foregroundColor(.primary)
                .padding(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(
            course: courseData[1],
            show: .constant(true),
            active: .constant(true),
            activeIndex: .constant(-1)
        )
    }
}
