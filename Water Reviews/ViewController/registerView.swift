//
//  registerView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/17/24.
//

import SwiftUI
import AuthenticationServices


struct registerView: View
{
    // Set up variables for username and password
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var confirm:String = ""
    
    @State private var showAlert:Bool = false
    @State private var feedbackMsg = ""
    
    var body: some View
    {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.2)
                .foregroundColor(.white.opacity(0.3))
            
            // Vstack for title, inputs, and buttons
            VStack{
                
                TextField(" Email", text: $username)
                    .frame(width: 250,height: 50)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                
                SecureField(" Password", text: $password)
                    .frame(width: 250,height: 50)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                
                SecureField(" Confirm Password", text: $confirm)
                    .frame(width: 250,height: 50)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                
                Button(action: {
                    feedbackMsg = registerSubmit(email: username, password: password, confirm: confirm) { error in
                        if let error = error {
                          // Handle the error here
                          feedbackMsg = "Error creating user: " + error.localizedDescription
                        } else {
                          // User created successfully
                            feedbackMsg = "User created!"
                        }
                      }
   
                    self.showAlert = true
                }, label: {
                    Text("Sign Up")
                })
                .font(.system(size: 20))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 50)
                .background(.white .opacity(0.3))
                .clipShape(.buttonBorder)
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Feedback"), message: Text(feedbackMsg))
                })
                
                
            .padding()
            }
            .navigationTitle("Register")
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
            
        }
        
    }
}
