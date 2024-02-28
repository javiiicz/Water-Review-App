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
    // Use the user ID here for further actions
}


// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard var selectedImage = info[.originalImage] as? UIImage else { return }
        selectedImage = cropImageToSquare(selectedImage)!
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}


// Crop image to square
func cropImageToSquare(_ image: UIImage) -> UIImage? {
  let ciImage = CIImage(image: image)
    guard let inputImage = ciImage else { return nil }

  let minDimension = min(inputImage.extent.width, inputImage.extent.height)
  let cropRect = CGRect(x: 0, y: 0, width: minDimension, height: minDimension)

  let croppedImage = inputImage.cropped(to: cropRect)
    return UIImage(ciImage: croppedImage)
}
