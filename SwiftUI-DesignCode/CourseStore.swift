//
//  CourseStore.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/31/21.
//

import SwiftUI
import Contentful

let client = Client(
    spaceId: "clokf4b0c1at",
    accessToken: "Bk49xGSZvlyh_A_ZENiro50otBRo9h0O2HX9GPXkjbg"
)

func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        print(result, "HIT <<<<<<")
    }
}
