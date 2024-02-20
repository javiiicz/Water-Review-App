//
//  landingView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/19/24.
//

import Foundation

//
//  landingView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/19/24.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth


struct landingView: View
{
    // Global user object
    @StateObject var signedUser = SignedUser()
    
    // View
    var body: some View
    {
        Text("Hello")
        Text(signedUser.email)
    }
      
}
