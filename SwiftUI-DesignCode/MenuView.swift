//
//  MenuView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/29/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                MenuRow(title:"Account", iconName: "gear")
                MenuRow(title:"Billing", iconName: "creditcard")
                MenuRow(title:"Account", iconName: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(radius: 30)
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    
    var title: String
    var iconName: String
    var size: CGFloat = 20.0
    var spacing: Int = 16
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.system(size: size, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
            Text(title)
                .font(.system(size: size, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
