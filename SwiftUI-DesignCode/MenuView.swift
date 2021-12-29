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
                Text("James - 28% complete")
                    .font(.caption)
                    .foregroundColor(.black)
                    .bold()
                
                ProgressBar()

                MenuRow(title:"Account", iconName: "gear")
                MenuRow(title:"Billing", iconName: "creditcard")
                MenuRow(title:"Sign out", iconName: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9932606816, green: 0.9932606816, blue: 0.9932606816, alpha: 1)), Color(#colorLiteral(red: 0.8916490674, green: 0.8994777799, blue: 0.9694784284, alpha: 1)), Color(#colorLiteral(red: 0.8229213357, green: 0.8178169131, blue: 0.9513029456, alpha: 1)),]), startPoint: .top, endPoint: .bottom)
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.blue.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Avatar()
            )
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
                .foregroundColor(Color("card1").opacity(0.7))
            Text(title)
                .font(.system(size: size, weight: .bold, design: .default))
                .foregroundColor(.black)
                .frame(width: 120, alignment: .leading)
            
        }
    }
}

struct Avatar: View {
    var body: some View {
        Image("Avatar")
            .resizable()
            .aspectRatio( contentMode: .fill)
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .offset(y: -150)
    }
}

struct ProgressBar: View {
    var body: some View {
        Color.white// Color counts as a view
            .frame(width: 38, height: 6) // set inner progress bar frame
            .cornerRadius(3)             // set corder radius of innerProgressBarFrame
            .frame(width:130, height: 6, alignment: .leading) // set outer progressBar frame
            .background(Color.black.opacity(0.08)) // set color of outer progressBar frame
            .cornerRadius(3)
            .padding()
            .frame(width: 150, height: 24)
            .background(Color.black.opacity(0.1))
            .cornerRadius(12)
            .shadow(radius: 20)
    }
}
