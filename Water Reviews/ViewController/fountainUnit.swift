//
//  fountainUnit.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 3/3/24.
//
// This is an individual unit for the water fountains shown in the explore page.

import SwiftUI
import FirebaseStorage

struct fountainUnit: View {
    // Var for alert
    @State var showAlert:Bool = false
    
    // Passed info variables
    var name:String = ""
    var author:String = ""
    var desc:String = ""
    var flow:Int = 10
    var flavor:Int = 10
    var temperature:Int = 10
    var location:Int = 10
    var imgPath:String = ""
    
    // Image var
    @State private var image: UIImage? = nil
    
    var body: some View {
        ZStack {
            // Background frame
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .frame(width: 330, height: 330)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            
            VStack{
                // Name
                Text(name)
                    .font(.system(size: 25, weight: .bold))
                
                // Author
                Text("By " + author)
                    .font(.system(size: 15))
                
                HStack{
                    ZStack{
                        // Image
                        if let image = image {
                            Image(uiImage: image) // Use downloaded image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(.rect(cornerRadius: CGFloat(10)))
                        } else {
                            // Placeholder image while downloading
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(.rect(cornerRadius: CGFloat(10)))
                                .onTapGesture {
                                    downloadImage() // Download image when tapped
                                }
                        }
                    }
                    
                    VStack{
                        // Ratings + average
                        Text("🌊 : " + String(flow))
                        Text("👅 : " + String(flavor))
                        Text("❄️ : " + String(temperature))
                        Text("📍 : " + String(location))
                        Text("")
                        let average = CGFloat(flow + flavor + temperature + location)
                        Text(String(average * 10/4))
                    }
                    .font(.system(size: 25, weight: .bold))
                }
                
                Button(action: {showAlert.toggle()}, label: {
                    Text("View Description")
                })
                .font(.system(size: 20))
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Description"), message: Text(desc))})
            }
        }
    }
    
    // Downloads an image and stores it in self.image variable
    private func downloadImage() {
        // Initializae Firebase storage
        let storage = Storage.storage()
        
        // Create reference to image path
        let storageRef = storage.reference(withPath: imgPath)
        
        // Set max size to 1Mb avoid downloading big images
        // Images taken should not be more than 500 Kb
        let maxSize = Int64(1) * 1024 * 1024
        
        // Get the data
        storageRef.getData(maxSize: maxSize) { data, error in
            if let error = error {
                print(error)
            } else {
                // Data is returned
                let image = UIImage(data: data!)
                self.image = image
                print("Success")
            }
        }
    }
}

