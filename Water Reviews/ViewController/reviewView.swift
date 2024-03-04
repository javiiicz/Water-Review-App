//
//  reviewView.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/23/24.
//

import SwiftUI
import PhotosUI

struct reviewView: View {
    
    // Variable o go back
    @State private var goBack:Bool = false
    
    // Var to hidekeyboard when tapped outside textFields
    @State private var textFieldId: String = UUID().uuidString
    
    // Image var
    @State private var showCamera = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var image: UIImage?
    
    //Sliders
    @State private var dragOffset1: CGFloat = 0.0
    @State private var initialDragOffset1: CGFloat = 0.0
    
    @State private var dragOffset2: CGFloat = 0.0
    @State private var initialDragOffset2: CGFloat = 0.0
    
    @State private var dragOffset3: CGFloat = 0.0
    @State private var initialDragOffset3: CGFloat = 0.0
    
    @State private var dragOffset4: CGFloat = 0.0
    @State private var initialDragOffset4: CGFloat = 0.0
    
    // State variables for feedback messages
    @State private var showAlert:Bool = false
    
    // Name and Description fields
    @State var name:String = ""
    @State var description:String = ""
    
    var body: some View {
        // Redirect to landing if user set goBack
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
                
                // Main VStack
                VStack{
                    // Title
                    HStack(spacing: 90){
                        VStack{
                            Text("Review")
                                .font(.system(size: 40,weight: .heavy))
                            
                            Text(MyVariables.email)
                                .font(.system(size: 15,weight: .heavy))
                        }
                        
                        // Back button
                        Button(action: {
                            withAnimation {
                                self.goBack = true
                            }
                        }, label: {
                            Text("Back")
                                .tint(.black)
                        })
                    }.padding([.top], 80)
                    
                    ScrollView{
                        VStack{
                            // Name Text Field
                            VStack{
                                TextField(" Name", text: $name)
                                    .id(textFieldId)
                                    .onTapGesture {} // So that outer tap gesture has no effect on field
                                    .frame(width: 330)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.system(size: 25, weight: .bold))
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .multilineTextAlignment(.center)
                            }
                            
                            // Camera and Button
                            VStack{
                                // Sets image
                                if let selectedImage{
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 300)
                                        .clipShape(.rect(cornerRadius: CGFloat(10)))
                                }
                                // If not, sets placeholder
                                else{
                                    Image("placeholder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 300)
                                        .clipShape(.rect(cornerRadius: CGFloat(10)))
                                }
                                
                                // Button to open camera using accessCameraView
                                Button("Open camera") {
                                    self.showCamera.toggle()
                                }
                                .fullScreenCover(isPresented: self.$showCamera) {
                                    accessCameraView(selectedImage: self.$selectedImage)
                                }
                                .font(.system(size: 20))
                                .tint(.black)
                                .frame(width: 300, height: 40)
                                .background(.blue.opacity(0.7))
                                .clipShape(.buttonBorder)
                            }
                            
                            // Flow slider
                            ratingSlider(emoji: "🌊", type: "flow", dragOffset: $dragOffset1, initialDragOffset: $initialDragOffset1)
                            
                            // Flavor slider
                            ratingSlider(emoji: "👅", type: "flavor", dragOffset: $dragOffset2, initialDragOffset: $initialDragOffset2)
                            
                            // Temp slider
                            ratingSlider(emoji: "❄️", type: "temperature", dragOffset: $dragOffset3, initialDragOffset: $initialDragOffset3)
                            
                            // Location slider
                            ratingSlider(emoji: "📍", type: "location", dragOffset: $dragOffset4, initialDragOffset: $initialDragOffset4)
                            
                            // Ratings
                            let rating1 = floor(dragOffset1 / 20.5)
                            let rating2 = floor(dragOffset2 / 20.5)
                            let rating3 = floor(dragOffset3 / 20.5)
                            let rating4 = floor(dragOffset4 / 20.5)
                            
                            // Calculate average and show
                            HStack{
                                let average = ((rating1 + rating2 + rating3 + rating4) * 10) / 4
                                Text((round(average * 100)/100).description + " / 100")
                            }
                            
                            // Description and Submit button
                            VStack{
                                TextField(" Description", text: $description, axis: .vertical)
                                    .id(textFieldId)
                                    .onTapGesture {} // So that outer tap gesture has no effect on field
                                    .frame(width: 330)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.system(size: 20))
                                    .textInputAutocapitalization(.never)
                                    .lineLimit(7...7)
                                
                                // Submit
                                Button(action: {
                                    // Call submitreview with all the info
                                    submitReview(name: name, r1: rating1, r2: rating2, r3: rating3, r4: rating4, desc: description, image: selectedImage ?? UIImage(imageLiteralResourceName: "placeholder"))
                                    
                                    // Reset Sliders and desciption
                                    self.dragOffset1 = 0.0
                                    self.initialDragOffset1 = 0.0
                                    
                                    self.dragOffset2 = 0.0
                                    self.initialDragOffset2 = 0.0
                                    
                                    self.dragOffset3 = 0.0
                                    self.initialDragOffset3 = 0.0
                                    
                                    self.dragOffset4 = 0.0
                                    self.initialDragOffset4 = 0.0
                                    
                                    self.selectedImage = UIImage(imageLiteralResourceName: "placeholder")
                                    
                                    self.name = ""
                                    self.description = ""
                                    
                                    // Show the success alert
                                    self.showAlert.toggle()
                                    
                                }, label: {
                                    Text("Submit")
                                })
                                .font(.system(size: 20))
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 50)
                                .background(.white .opacity(0.3))
                                .clipShape(.buttonBorder)
                                .alert(isPresented: $showAlert, content: {
                                    Alert(title: Text("Feedback"), message: Text("Success uploading review!"))
                                })
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }.onTapGesture { // whenever tapped within VStack
                    textFieldId = UUID().uuidString
                    
                }
            }
        }
    }
}


// Struct for accessing the camera (With help from Gemini AI)
struct accessCameraView: UIViewControllerRepresentable {
    
    // Setup image variable and presentation
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
