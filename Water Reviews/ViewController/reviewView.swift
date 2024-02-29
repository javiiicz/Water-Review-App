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
    
    //Slider
    @State private var dragOffset: CGFloat = 0.0
    @State private var initialDragOffset: CGFloat = 0.0
    private let sliderWidth: CGFloat = 220.0
    private let circleSpacing: CGFloat = 44.0
    
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
                
                // Content VStack
                VStack {
                    ScrollView{
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
                            
                            // Flow slider
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .circular)
                                    .frame(width: 330, height: 100)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                                    
                                
                                VStack {
                                    HStack{
                                        Text("Rate the flow")
                                            .bold()
                                            .font(.title3)
                                        Text((floor(dragOffset / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("🌊")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset = dragOffset
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset = dragOffset
                                                })
                                            
                                        }
                                    }
                                }
                                .frame(width: 320, height: 80)
                                .padding()
                            
                            }
                            
                            // Flavor slider
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .circular)
                                    .frame(width: 330, height: 100)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                                    
                                
                                VStack {
                                    HStack{
                                        Text("Rate the flavor")
                                            .bold()
                                            .font(.title3)
                                        Text((floor(dragOffset / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("👅")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset = dragOffset
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset = dragOffset
                                                })
                                            
                                        }
                                    }
                                }
                                .frame(width: 320, height: 80)
                                .padding()
                            
                            }
                            
                            // Temp slider
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .circular)
                                    .frame(width: 330, height: 100)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                                    
                                
                                VStack {
                                    HStack{
                                        Text("Rate the temperature")
                                            .bold()
                                            .font(.title3)
                                        Text((floor(dragOffset / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("❄️")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset = dragOffset
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset = dragOffset
                                                })
                                            
                                        }
                                    }
                                }
                                .frame(width: 320, height: 80)
                                .padding()
                            
                            }
                            
                            
                        }
                        .padding()
                    }
                    .frame(width: .infinity, height: 600, alignment: .top)
                    
                }
                .frame(width: .infinity, height: 480, alignment: .top)
                

                
            }
        }
        
    }
}


// Struct for accessing the camera
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
