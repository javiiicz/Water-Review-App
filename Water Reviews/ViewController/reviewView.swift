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
    
    //Sliders
    @State private var dragOffset1: CGFloat = 0.0
    @State private var initialDragOffset1: CGFloat = 0.0
    @State private var dragOffset2: CGFloat = 0.0
    @State private var initialDragOffset2: CGFloat = 0.0
    @State private var dragOffset3: CGFloat = 0.0
    @State private var initialDragOffset3: CGFloat = 0.0
    @State private var dragOffset4: CGFloat = 0.0
    @State private var initialDragOffset4: CGFloat = 0.0
    private let sliderWidth: CGFloat = 220.0
    private let circleSpacing: CGFloat = 44.0
    
    // Description
    @State var description:String = ""
    
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
                
                // Main VStack
                VStack{
                    HStack(spacing: 90){
                        VStack{
                            Text("Review")
                                .font(.system(size: 40,weight: .heavy))
                            
                            Text(MyVariables.email)
                                .font(.system(size: 15,weight: .heavy))
                        }
                        
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
                            // Camera and Button
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
                                        Text((floor(dragOffset1 / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("🌊")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            MyShape().frame(width:230, height:15)
                                                .foregroundStyle(Color(.black.opacity(0.1)))
                                            MyShape().frame(width: dragOffset1 + 10, height: 15)
                                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .blue]), startPoint: .leading, endPoint: .trailing))
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset1)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset1 + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset1 = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset1 = dragOffset1
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset1 = dragOffset1
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
                                        Text((floor(dragOffset2 / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("👅")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            MyShape().frame(width:230, height:15)
                                                .foregroundStyle(Color(.black.opacity(0.1)))
                                            MyShape().frame(width: dragOffset2 + 10, height: 15)
                                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.pink, .yellow]), startPoint: .leading, endPoint: .trailing))
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset2)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset2 + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset2 = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset2 = dragOffset2
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset2 = dragOffset2
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
                                        Text((floor(dragOffset3 / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("❄️")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            MyShape().frame(width:230, height:15)
                                                .foregroundStyle(Color(.black.opacity(0.1)))
                                            MyShape().frame(width: dragOffset3 + 10, height: 15)
                                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset3)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset3 + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset3 = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset3 = dragOffset3
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset3 = dragOffset3
                                                })
                                            
                                        }
                                    }
                                }
                                .frame(width: 320, height: 80)
                                .padding()
                            
                            }
                            
                            // Location slider
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .circular)
                                    .frame(width: 330, height: 100)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                                    
                                
                                VStack {
                                    HStack{
                                        Text("Rate the location")
                                            .bold()
                                            .font(.title3)
                                        Text((floor(dragOffset4 / 2.05)).description)
                                            .font(.system(size: 15))
                                    }
                                    
                                    HStack{
                                        Text("📍")
                                            .font(.system(size: 40))
                                            .transition(.scale)
                                        ZStack (alignment: .leading){
                                            MyShape().frame(width:230, height:15)
                                                .foregroundStyle(Color(.black.opacity(0.1)))
                                            MyShape().frame(width: dragOffset4 + 10, height: 15)
                                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .leading, endPoint: .trailing))
                                            HStack (spacing: circleSpacing){
                                                ForEach(0..<5){index in
                                                    Circle().frame(width: 6+CGFloat(index) * 1, height: 6 + CGFloat(index) * 1)}
                                            }
                                            Circle().frame(width: 30,height: 30).offset(x: dragOffset4)
                                                .foregroundColor(.white).shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            let change = value.translation.width
                                                            let newValue = min(max(initialDragOffset4 + change, 0), self.sliderWidth - 15)
                                                            self.dragOffset4 = newValue
                                                        })
                                                        .onEnded({ value in
                                                            self.initialDragOffset4 = dragOffset4
                                                        })
                                                )
                                                .onAppear(perform: {
                                                    self.initialDragOffset4 = dragOffset4
                                                })
                                            
                                        }
                                    }
                                }
                                .frame(width: 320, height: 80)
                                .padding()
                            
                            }
                            
                            // Average
                            HStack{
                                let average = (floor(dragOffset1 / 2.05) + floor(dragOffset2 / 2.05) + floor(dragOffset3 / 2.05) + floor(dragOffset4 / 2.05)) / 4
                                Text((round(average * 100)/100).description + "/ 100")
                            }
                            
                            // Text Field anf Submit
                            VStack{
                                TextField(" Description", text: $description, axis: .vertical)
                                    .frame(width: 330,height: 250)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.system(size: 20))
                                    .textInputAutocapitalization(.never)
                                    .lineLimit(7...7)
                                
                                Button(action: {}, label: {
                                    Text("Submit")
                                })
                                .font(.system(size: 20))
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 50)
                                .background(.white .opacity(0.3))
                                .clipShape(.buttonBorder)
                            }
                        }
                    }
                    
                }
                

                
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
