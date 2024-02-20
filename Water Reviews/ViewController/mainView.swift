//
//  mainView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/17/24.
//

import SwiftUI
import AuthenticationServices


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

#Preview {
    mainView()
}
