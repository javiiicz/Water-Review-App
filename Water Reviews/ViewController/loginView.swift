//
//  loginView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/13/24.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth



struct loginView: View
{
    // Set up variables for username and password
    @State private var email:String = ""
    @State private var password:String = ""
    
    // State variables for feedback messages
    @State private var showAlert:Bool = false
    @State private var feedbackMsg:String = ""
    
    // State for showing landing page
    @State private var signedIn:Bool = false
    
    // View
    var body: some View
    {
        ZStack {
            if signedIn {
                landingView()
                    
            }
            else {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white.opacity(0.3))
                
                // Vstack for title, inputs, and buttons
                VStack{
                    Text("Log In")
                        .font(.system(size: 40,weight: .heavy))
                    
                    TextField(" Email", text: $email)
                        .frame(width: 250,height: 50)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 20))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureField(" Password", text: $password)
                        .frame(width: 250,height: 50)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 20))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    // Sign in Button and logistics
                    Button(action: {
                        
                        // Check inputs have stuff
                        if email == "" || password == "" {
                            feedbackMsg = "Error: One of the inputs is empty."
                            self.showAlert = true
                        }
                        
                        // Check email
                        else if !isValidEmail(email) {
                            feedbackMsg =  "Error: The email is not valid."
                            self.showAlert = true
                        }
                        
                        else {
                            //Sign out first
                            let firebaseAuth = Auth.auth()
                            do {
                              try firebaseAuth.signOut()
                            } catch let signOutError as NSError {
                              print("Error signing out: %@", signOutError)
                            }
                            
                            // Try to authenticate
                            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                if error == nil {
                                    //Success
                                    self.signedIn = true
                                    
                                    
                                    
                                }
                                else {
                                    //Handle error
                                    feedbackMsg =  error!.localizedDescription
                                    self.showAlert = true
                                }
                            }
                        }

                    }, label: {
                        Text("Sign In")
                    })
                    .font(.system(size: 20))
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 50)
                    .background(.white .opacity(0.3))
                    .clipShape(.buttonBorder)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Feedback"), message: Text(feedbackMsg))
                    })
                    
                    // Link for opeing Register navigation view
                    HStack{
                        Text("Don't have an account?")
                        
                        NavigationLink("Register"){
                            registerView()
                        }
                    }
                }
            .padding()
            }
        }
    }
}
