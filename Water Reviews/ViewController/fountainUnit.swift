//
//  fountainUnit.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 3/3/24.
//

import SwiftUI
import FirebaseStorage

// This is an individual unit for the water fountains shown in the explore page.
struct fountainUnit: View {
    @State var showAlert:Bool = false
    var name:String = ""
    var author:String = ""
    var desc:String = ""
    var flow:Int = 10
    var flavor:Int = 10
    var temperature:Int = 10
    var location:Int = 10
    var imgPath:String = ""
    
    @State private var image: UIImage? = nil
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .frame(width: 330, height: 330)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            
            
            VStack{
                Text(name)
                    .font(.system(size: 25, weight: .bold))
                
                Text("By " + author)
                    .font(.system(size: 15))
                
                HStack{
                    ZStack{
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
                        }
                        
                        Button("Download Image") {
                                downloadImage()
                              }
                        .offset(CGSize(width: 0.0, height: 85.0))
                        .tint(.gray)
                    }
                    
                    VStack{
                        Text("🌊 : " + String(flow))
                        Text("👅 : " + String(flavor))
                        Text("❄️ : " + String(temperature))
                        Text("📍 : " + String(location))
                        Text("")
                        let average = (flow + flavor + temperature + location)/4
                        Text(String(average * 10))
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
    
    private func downloadImage() {
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: imgPath)
        
        let intVar = 1 // Assuming this is within Int64 range
        let maxSize = Int64(intVar) * 1024 * 1024
        
        storageRef.getData(maxSize: maxSize) { data, error in
            if let error = error {
                // error occurred
            } else {
                // Data is returned
                let image = UIImage(data: data!)
                self.image = image
            }
        }
    }
}


#Preview {
    fountainUnit()
}
