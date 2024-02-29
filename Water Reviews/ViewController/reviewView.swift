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
    struct EmojiSection{
        let emoji: String
        let description: String
        let range: ClosedRange<Double>
    }
    private let sections: [EmojiSection] = [
        EmojiSection(emoji: "☹️", description: "Sad", range: 0...0.2),
        EmojiSection(emoji: "🙁", description: "Subpar", range: 0.2...0.45),
        EmojiSection(emoji: "😐", description: "Okay", range: 0.45...0.70),
        EmojiSection(emoji: "🙂", description: "Good", range: 0.70...0.93),
        EmojiSection(emoji: "😁", description: "Excellent", range: 0.93...1)
    ]
    
    var body: some View {
        let progress = dragOffset / sliderWidth
        let currentSection = sections.first(where: {$0.range.contains(Double(progress))}) ?? sections.last
        
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
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .circular)
                            .frame(width: 330, height: 100)
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                            
                        
                        VStack {
                            HStack{
                                Text("Rate your experience")
                                    .bold()
                                    .font(.title3)
                                Text(currentSection?.description ?? "")
                                    .font(.system(size: 15))
                            }
                            
                            HStack{
                                Text(currentSection?.emoji ?? "")
                                    .font(.system(size: 40))
                                    .transition(.scale)
                                    .animation(.easeOut(duration: 0.3), value: currentSection?.emoji)
                                ZStack (alignment: .leading){
                                    HStack (spacing: circleSpacing){
                                        ForEach(0..<sections.count,id:\.self){index in
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
