//
//  functions.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/18/24.
//

import Foundation
import Firebase
import FirebaseAuth
import AuthenticationServices

// Variables
struct MyVariables {
    static var email = ""
    static var id = ""
}

// Returns true if the email has a valid format
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}


// Handles sign in result
func handleSignInResult(result: AuthDataResult) {
    // Sign-in successful, get user ID
    let userEmail = result.user.email
    MyVariables.email = userEmail!
    print("User ID: \(userEmail!)")
    // Use the user ID here for further actions
}


