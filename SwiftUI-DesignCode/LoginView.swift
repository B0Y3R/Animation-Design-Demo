//
//  LoginView.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 1/1/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isFocused: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = "somthing went wrong"
    @State var isLoading: Bool = false
    @State var isSuccessful: Bool = false
    
    
    func login() {
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isLoading = false
            
            if error != nil {
                alertMessage = error?.localizedDescription ?? "somthing went wrong"
                self.showAlert = true
            } else {
                self.isSuccessful = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isSuccessful = false
                }
                
                self.email = ""
                self.password = ""
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil , for: nil)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // back layer
            ZStack(alignment: .top) {
                BackLayerView()

                CoverView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color.blue.opacity(0.5))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    
                    Divider()
                        .padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color.blue.opacity(0.5))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                        
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(
                    BlurView(style: .systemMaterial)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: 460)
                
                HStack {
                    Text("Forgot Password?")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    Button(action: { login() }) {
                        Text("Log in")
                            .foregroundColor(Color.white)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color.blue.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()

            }
            .offset(y: isFocused ? -300 : 0)
            .animation(isFocused ? .easeInOut : nil) // allows you to enabled or disable an animation based on state
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            
            if isLoading {
                LoadingView()
            }
            
            if isSuccessful {
                SuccessView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    
    @State var viewState: CGSize = CGSize.zero
    @State var show: Bool = false
    @State var isDragging: Bool = false
    
    var body: some View {
        VStack {                                                                        // top layer
            GeometryReader { geometry in                                                // wrap Text in a geometry reader
                Text("Learn design & code.\nFrom scratch.")
                    .font(.system(size: geometry.size.width / 10, weight: .bold))       // take screen size into account when displaying title fonts
                    .foregroundColor(Color(.white))
            }
            .frame(maxWidth: 375, maxHeight: 100) // ideal max font size
            .padding(.horizontal, 16)
            .offset(x: viewState.width / 15, y: viewState.height / 15)
            
            
            Text("80 hours of courses for SwiftUI, React, and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .foregroundColor(.primary)
                .offset(x: viewState.width / 20, y: viewState.height / 20)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {                                                                // build out two images, blobs in this instance
                Image("Blob")
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))             // added rotation effect, +90 so it doesnt skip
                    .blendMode(.plusDarker)
                    .onAppear {
                        self.show = true
                    }
                Image("Blob")
                    .offset(x: -200, y: -50)
                    .blendMode(.overlay)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 0), anchor: .topLeading)
            }
                .animation(Animation.linear(duration: 40).repeatForever())    // animation for the zStack with both blobs, animating the rotation
        )
        .background(Image("Card3").offset(x: viewState.width / 20, y: viewState.height / 20), alignment: .bottom)
        .background(Color("card1"))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.8 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.isDragging = true
                    self.viewState = value.translation
                }
                .onEnded { value in
                    self.isDragging = false
                    self.viewState = .zero
                }
        )
    }
}

struct BackLayerView: View {
    var body: some View {
        Color("background2") // middle layer
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .edgesIgnoringSafeArea(.bottom)
    }
}
