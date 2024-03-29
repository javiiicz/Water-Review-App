//
//  mainView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/17/24.
//
// Redirects to loginView

import SwiftUI
import AuthenticationServices
import FirebaseAuth


// Main View
struct mainView: View {
    
    var body: some View {
        return Group {
            NavigationStack{
                loginView()
            }
            .tint(.blue)
        }
    }
}
