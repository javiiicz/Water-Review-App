//
//  landingView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/19/24.
//
// Landing view user see when logged in

import Foundation
import SwiftUI
import AuthenticationServices
import FirebaseAuth


struct landingView: View
{
    // State for showing landing page
    @State private var signedIn:Bool = true
    @State private var showReview:Bool = false
    @State private var showExplore:Bool = false
    
    // View
    var body: some View
    {
        // Handles switching to other views
        if signedIn {
            if showReview{
                reviewView()
                    .transition(.push(from: .leading))
            }
            else if showExplore{
                exploreView()
                    .transition(.push(from: .leading))
            }
            else{
                // Background
                ZStack{
                    Color.blue
                        .ignoresSafeArea()
                    
                    Circle()
                        .scale(0.9)
                        .foregroundColor(.white.opacity(0.15))
                        .offset(CGSize(width: -70.0, height: -200.0))
                    
                    Circle()
                        .scale(0.7)
                        .foregroundColor(.white.opacity(1))
                        .offset(CGSize(width: -70.0, height: -200.0))
                    
                    Rectangle()
                        .foregroundColor(.white.opacity(1))
                        .frame(height: 700)
                        .offset(CGSize(width: 0, height: 100))
                    
                    // Title VStack
                    VStack{
                        Text("Welcome")
                            .font(.system(size: 40,weight: .heavy))
                            .offset(CGSize(width: -70, height: -250))
                        
                        Text(MyVariables.email)
                            .font(.system(size: 15,weight: .heavy))
                            .offset(CGSize(width: -70, height: -250))
                        
                        // Button for signing out and returning to log in view
                        Button(action: {
                            let firebaseAuth = Auth.auth()
                            do {
                              try firebaseAuth.signOut()
                            } catch let signOutError as NSError {
                              print("Error signing out: %@", signOutError)
                            }
                            withAnimation {
                                signedIn = false
                            }
                        }, label: {
                            Text("Sign out")
                                .tint(.black)
                        })
                        .offset(CGSize(width: 140.0, height: -300.0))
                    }
                    
                    // Button Vstack
                    VStack{
                        Text("What would you like to do?")
                            .font(.system(size: 20,weight: .heavy))
                        
                        // Review Button
                        Button(action: {
                            withAnimation {
                                self.showReview = true
                            }
                        }, label: {
                            Text("Review")
                        })
                        .font(.system(size: 30, weight: .heavy))
                        .tint(.black)
                        .frame(width: 300, height: 250)
                        .background(.blue.opacity(0.7))
                        .clipShape(.buttonBorder)
                        
                        // Explore Button
                        Button(action: {
                            withAnimation {
                                self.showExplore = true
                            }
                        }, label: {
                            Text("Explore")
                        })
                        .font(.system(size: 30, weight: .heavy))
                        .tint(.black)
                        .frame(width: 300, height: 250)
                        .background(.cyan.opacity(0.7))
                        .clipShape(.buttonBorder)
                    }
                    .offset(CGSize(width: 0, height: 90.0))
                }
            }
        }
        
        // If not signed in, redirect to login View
        else{
            loginView()
                .transition(.opacity)
        }
    }
}
