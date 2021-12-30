//
//  UpdateDetail.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/30/21.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update = updateData[1]
    
    var body: some View {
        VStack(spacing: 20) {
            Image(update.image)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
            Text(update.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
        }
        .navigationBarTitle(update.title)
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
