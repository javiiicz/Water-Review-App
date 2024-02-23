//
//  reviewView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/23/24.
//

import SwiftUI

struct reviewView: View {
    
    // To go back
    @State private var goBack:Bool = false
    
    var body: some View {
        
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
                
                // Title VStack
                VStack{
                    Text("Review")
                        .font(.system(size: 40,weight: .heavy))
                        .offset(CGSize(width: -70, height: -250))
                    Text(MyVariables.email)
                        .font(.system(size: 15,weight: .heavy))
                        .offset(CGSize(width: -70, height: -250))
                    Button(action: {
                        withAnimation {
                            self.goBack = true
                        }
                        
                        
                    }, label: {
                        Text("Back")
                            .tint(.black)
                    })
                    .offset(CGSize(width: 140.0, height: -300.0))
                }
                
            }
        }
        
    }
}
