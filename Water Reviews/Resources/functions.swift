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
import SwiftUI
import FirebaseFirestore


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
    // Use the user ID here for further actions
}


// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

// Shape creator for sliders
struct MyShape: Shape {
    func path(in rect: CGRect) -> Path{
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x:0, y: 0.5*height))
        
        path.addCurve(to: CGPoint(x:0.01522*width, y:0.26261*height), control1: CGPoint(x:0, y:0.37048*height), control2: CGPoint(x:0.00677*width, y:0.26486*height))
        path.addLine(to: CGPoint(x: 0.9674*width, y: 0.00869*height))
        
        path.addCurve(to: CGPoint(x:width, y:0.5*height), control1: CGPoint(x:0.98531*width, y:0.00392*height), control2: CGPoint(x:width, y:0.22528*height))
        path.addLine(to: CGPoint(x: width, y: 0.5*height))
        
        path.addCurve(to: CGPoint(x:0.9674*width, y:0.99131*height), control1: CGPoint(x:width, y:0.77473*height), control2: CGPoint(x:0.98531*width, y:0.99608*height))
        path.addLine(to: CGPoint(x: 0.01522*width, y: 0.73739*height))
        
        path.addCurve(to: CGPoint(x:0, y:0.5*height), control1: CGPoint(x:0.00677*width, y:0.73514*height), control2: CGPoint(x:0, y:0.62952*height))
        path.addLine(to: CGPoint(x: 0*width, y: 0.5*height))
        
        path.closeSubpath()
        
        return path
    }
}

func submitReview() -> Void{
    let db = Firestore.firestore()
    let fountainRef = db.collection("waterFountains").document()
    fountainRef.setData([
        "id": fountainRef.documentID, // Use generated ID
        "rating": 1,
        "description": "hello",
        "photoUrls": "imageUrlString"
    ]) { error in
        if let error = error {
            print("Error saving water fountain data:", error.localizedDescription)
        } else {
            print("Water fountain data saved successfully!")
        }
    }
}
