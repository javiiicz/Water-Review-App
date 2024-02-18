//
//  functions.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/18/24.
//

import Foundation
import FirebaseAuth


// Returns true if the email has a valid format
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

// Checks validity for registration
func registerSubmit(email:String, password:String, confirm:String, completion: @escaping (Error?) -> Void)-> String{
    var alertMsg:String = ""
    
    // Check inputs have stuff
    if email == "" || password == "" || confirm == "" {
        alertMsg = "Error: One of the inputs is empty."
        return alertMsg
    }
    
    // Check email
    if !isValidEmail(email) {
        alertMsg = "Error: The email is not valid."
        return alertMsg
    }
    
    // Check password and confirm match
    if password != confirm {
        alertMsg = "Error: Password and confirmation do not match."
        return alertMsg
    }
    
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        completion(error) // Pass the error to the completion handler
      }
    return alertMsg
}



