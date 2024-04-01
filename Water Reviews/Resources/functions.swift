//
//  functions.swift
//  Water Reviews
//
//  Creacted by Javier Carrillo on 2/18/24.
//
// The functions used throughout the project

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth
import AuthenticationServices
import SwiftUI
import FirebaseFirestore


// Global Variables (just used for email)
struct MyVariables {
    static var email = ""
}


// Returns true if the email has a valid format
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}


// Handles sign in result
func handleSignInResult(result: AuthDataResult) {
    // Sign-in successful, get user email
    let userEmail = result.user.email
    MyVariables.email = userEmail!
}


// Camera Coordinator (Gemini AI)
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


// Custom Shape for ratingSlider
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


// Stores the review in FirebaseDatabase
func submitReview(name: String, r1: CGFloat, r2: CGFloat, r3: CGFloat, r4: CGFloat, desc: String, image: UIImage) -> Void{
    
    // Access the Database
    let db = Firestore.firestore()
    let fountainRef = db.collection("waterFountains").document()
    
    // Get Fountain ID
    let fountainID = fountainRef.documentID
    
    // Upload photo to Firebase Storage
    let storageRef = Storage.storage().reference()
    let photoRef = storageRef.child("waterFountains/" + fountainID + ".jpg")
    let imageData = image.jpegData(compressionQuality: 0.2)!
    photoRef.putData(imageData, metadata: nil) { metadata, error in
        if let error = error {
            print("Error uploading photo:", error.localizedDescription)
            return
        }
    }
    
    // Update the database
    fountainRef.setData([
        "id": fountainID, // Use generated ID
        "name": name,
        "flow": r1,
        "flavor": r2,
        "temperature": r3,
        "location": r4,
        "description": desc,
        "photoPath": "waterFountains/" + fountainID + ".jpg",
        "createdAt": Timestamp(),
        "createdBy": MyVariables.email
    ]) { error in
        if let error = error {
            print("Error saving water fountain data:", error.localizedDescription)
        } else {
            print("Water fountain data saved successfully!")
        }
    }
}


// Obtains the fountains in the database
func getFountains(completion: @escaping ([QueryDocumentSnapshot]?) -> Void) {
    // Initialize database
    let db = Firestore.firestore()
    // Create query
    let query = db.collection("waterFountains").order(by: "createdAt", descending: true)

    // Get documents
    query.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error fetching water fountains:", error.localizedDescription)
            completion(nil) // Return with error indication
            return
        }
        let fountains = querySnapshot?.documents ?? []
        completion(fountains) // Return with fetched data
    }
}
