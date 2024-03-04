//
//  exploreView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/23/24.
//

import SwiftUI

struct exploreView: View {
    
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
                            fountainUnit()
                            fountainUnit()
                            fountainUnit()
                        }
                    }
                }
                
            }
        }
        
    }
}

#Preview {
    exploreView()
}
