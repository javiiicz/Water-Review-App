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


// Returns true if the email has a valid format
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}


// Handles sign in result
func handleSignInResult(result: AuthDataResult, userObj: SignedUser) {
    // Sign-in successful, get user ID
    let userEmail = result.user.email
    userObj.email = userEmail!
    print("User ID: \(userEmail!)")
    // Use the user ID here for further actions
}


