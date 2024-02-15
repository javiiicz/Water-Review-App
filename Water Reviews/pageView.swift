//
//  ContentView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/13/24.
//

import SwiftUI
import AuthenticationServices



struct pageView: View
{
    var body: some View 
    {
        VStack 
        {
            NavigationView 
            {
                VStack 
                {
                    Text("hello")
                    }
                }
                .navigationTitle("Sign In")
        }
        .padding()
    }
}

#Preview {
    pageView()
}
