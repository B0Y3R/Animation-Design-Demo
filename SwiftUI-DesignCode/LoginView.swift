//
//  LoginView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 1/1/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Color("background2").edgesIgnoringSafeArea(.bottom)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            VStack {
                GeometryReader { geometry in                                                // wrap Text in a geometry reader
                    Text("Learn design & code.\nFrom scratch.")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))       // take screen size into account when displaying title fonts
                }
                .frame(maxWidth: 375, maxHeight: 100) // ideal max font size
                .padding(.horizontal, 16)
                .foregroundColor(Color("background1"))

                
                Text("80 hours of courses for SwiftUI, React, and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                    .foregroundColor(.primary)

                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image("Blob")
                        .offset(x: -150, y: -200)
                    .blendMode(.plusDarker)
                    Image("Blob")
                        .offset(x: -200, y: -250)
                        .blendMode(.overlay)
                }
            )
            .background(
                
                Image("Card3"),
                alignment: .bottom
            )
            .background(Color("card1"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
