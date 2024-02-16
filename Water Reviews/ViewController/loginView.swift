//
//  loginView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/13/24.
//

import SwiftUI
import AuthenticationServices

// Main Login View
struct loginView: View
{
    // Set up variables for username and password
    @State private var username:String = ""
    @State private var password:String = ""
    
    // View
    var body: some View
    {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            
            // Vstack for title, inputs, and buttons
            VStack{
                Text("Log In")
                    .font(.system(size: 40,weight: .heavy))
                
                TextField(" Username", text: $username)
                    .frame(width: 250,height: 50)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                
                TextField(" Password", text: $password)
                    .frame(width: 250,height: 50)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign In")
                })
                .font(.system(size: 20))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 50)
                .background(.white .opacity(0.3))
                .clipShape(.buttonBorder)
                
                // Link for opeing Register navigation view
                HStack{
                    Text("Don't have an account?")
                    
                    NavigationLink("Register"){
                       // RegisterView()
                    }
            }
            .padding()
            
            
            
        }
        
        
            
        }
    }
}



#Preview {
    loginView()
}
