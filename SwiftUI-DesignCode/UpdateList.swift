//
//  UpdateList.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/29/21.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        NavigationView {
            List(updateData) { update in
                NavigationLink(destination: Text(update.text)) {
                    HStack {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 4)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            Text(update.text)
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(Color.black.opacity(0.6))
                            
                            Text(update.date)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle("Updates")
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take you SwiftUI app to the App Store with advanced techniques like API data, packes and CMS.", date: "Jan 1st"),
    Update(image: "Card2", title: "WebFlow", text: "Design and animate a high converting landing page with advanced interactions, payments, and CMS", date: "Oct 17th"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions ofr mobile and Web.", date: "Aug 28th"),
    Update(image: "Card4", title: "SwiftUI Basics", text: "Learn how to code custom UIs, animations, gestures and components in Xcode11.", date: "Jun 20th"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer Xcode editor", date: "Jun 11th"),
]
