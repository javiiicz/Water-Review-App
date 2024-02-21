//
//  landingView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/19/24.
//

import Foundation
import SwiftUI
import AuthenticationServices
import FirebaseAuth


struct landingView: View
{
    // View
    var body: some View
    {
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
            
            VStack{
                Text("Hello")
                Text(MyVariables.email)
                
            }
        }
        
        
    }
}

#Preview {
    landingView()
}
