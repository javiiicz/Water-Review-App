//
//  reviewView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/23/24.
//

import SwiftUI
import PhotosUI

struct reviewView: View {
    
    // To go back
    @State private var goBack:Bool = false
    
    // Image var
    @State private var showCamera = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var image: UIImage?
    
    var body: some View {
        
        if goBack{
            landingView()
                .transition(.push(from: .leading))
        }
        else{
            // Background
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                
                Circle()
                    .scale(0.9)
                    .foregroundColor(.white.opacity(0.15))
                    .offset(CGSize(width: -70.0, height: -200.0))
                
                Circle()
                    .scale(0.7)
                    .foregroundColor(.white.opacity(1))
                    .offset(CGSize(width: -70.0, height: -200.0))
                
                Rectangle()
                    .foregroundColor(.white.opacity(1))
                    .frame(height: 700)
                    .offset(CGSize(width: 0, height: 100))
                
                // Title VStack
                VStack{
                    Text("Review")
                        .font(.system(size: 40,weight: .heavy))
                        .offset(CGSize(width: -70, height: -250))
                    Text(MyVariables.email)
                        .font(.system(size: 15,weight: .heavy))
                        .offset(CGSize(width: -70, height: -250))
                    Button(action: {
                        withAnimation {
                            self.goBack = true
                        }
                        
                        
                    }, label: {
                        Text("Back")
                            .tint(.black)
                    })
                    .offset(CGSize(width: 140.0, height: -300.0))
                }
                
                VStack{
                    if let selectedImage{
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .clipShape(.rect(cornerRadius: CGFloat(10)))
                    }
                    else{
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .clipShape(.rect(cornerRadius: CGFloat(10)))
                    }
                    
                    Button("Open camera") {
                        self.showCamera.toggle()
                    }
                    .fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                    }
                    .font(.system(size: 20))
                    .tint(.black)
                    .frame(width: 170, height: 60)
                    .background(.blue.opacity(0.7))
                    .clipShape(.buttonBorder)
                    
                    
                }

                
            }
        }
        
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}


#Preview{
    reviewView()
}
