//
//  exploreView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/23/24.
//
// Displays each review in a scrollable area with all info

import SwiftUI
import FirebaseFirestore

struct exploreView: View {
    
    // Variable to go back
    @State private var goBack:Bool = false
    
    // Variable for list of fountains
    @State private var fountains: [QueryDocumentSnapshot] = []
    
    var body: some View {
        // IF user set goBlack flag, redirect
        if goBack{
            landingView()
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
                
                // Main VStack
                VStack{
                    
                    //Title
                    HStack(spacing: 90){
                        VStack{
                            Text("Explore")
                                .font(.system(size: 40,weight: .heavy))
                            
                            Text(MyVariables.email)
                                .font(.system(size: 15,weight: .heavy))
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.goBack = true
                            }
                        }, label: {
                            Text("Back")
                                .tint(.black)
                        })
                    }.padding([.top], 80)
                    
                    // Scrollable view
                    ScrollView{
                        VStack{
                            // For each element in fountains, create a fountainUnit with all the info
                            ForEach(fountains, id: \.self) { fountain in
                                fountainUnit(name: fountain.get("name") as! String, 
                                             author: fountain.get("createdBy") as! String,
                                             desc: fountain.get("description") as! String,
                                             flow: fountain.get("flow") as! Int,
                                             flavor: fountain.get("flavor") as! Int,
                                             temperature: fountain.get("temperature") as! Int,
                                             location: fountain.get("location") as! Int,
                                             imgPath: fountain.get("photoPath") as! String
                                )
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .onAppear { // Call getFountains on view appearance
                            getFountains { fountains in
                                self.fountains = fountains ?? [] // Update state with fetched data
                            }
                        }
                    }
                }
            }
        }
    }
}
