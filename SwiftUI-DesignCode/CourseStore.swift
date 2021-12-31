//
//  CourseStore.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/31/21.
//

import SwiftUI
import Combine
import Contentful

let client = Client(
    spaceId: "clokf4b0c1at",
    accessToken: "Bk49xGSZvlyh_A_ZENiro50otBRo9h0O2HX9GPXkjbg"
)

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    let colors: [Color] = [Color(.purple), Color(.green), Color(.red), Color(.blue), Color(.brown)]
    
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(
                    Course(
                        title: item.fields["title"] as! String,
                        subtitle: item.fields["subtitle"] as! String,
                        image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                        logo: Image("Logo1"),
                        color: self.colors.randomElement()!,
                        show: false
                    )
                )
            }
        }
    }
}
