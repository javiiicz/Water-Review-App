//
//  fountainUnit.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 3/3/24.
//

import SwiftUI

// This is an individual unit for the water fountains shown in the explore page.
struct fountainUnit: View {
    @State var showAlert:Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .frame(width: 330, height: 330)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            
            
            VStack{
                Text("Fountain Name")
                    .font(.system(size: 25, weight: .bold))
                
                Text("By email@email.com")
                    .font(.system(size: 15))
                
                HStack{
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(.rect(cornerRadius: CGFloat(10)))
                    
                    VStack{
                        Text("🌊 : 10")
                        Text("👅 : 10")
                        Text("❄️ : 10")
                        Text("📍 : 10")
                        Text("")
                        Text("100")
                    }
                    .font(.system(size: 25, weight: .bold))
                }
                
                Button(action: {showAlert.toggle()}, label: {
                    Text("View Description")
                })
                .font(.system(size: 20))
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Description"), message: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus gravida, mi eget aliquet sollicitudin, eros metus accumsan lacus, feugiat fringilla tortor tortor sed mi. Vestibulum erat turpis, suscipit vel nisi et, malesuada dignissim felis. Vestibulum libero elit, feugiat et nunc et, aliquet rutrum neque. In mattis augue at ultricies fermentum. Aenean imperdiet justo eget nisi tempor, sit amet suscipit augue sagittis. Aliquam egestas urna sed enim euismod egestas. Integer lorem magna, vehicula a nulla vitae, porttitor feugiat lacus. Vivamus nec diam et lorem bibendum fermentum lacinia vitae augue."))})
            
            }
            
        }
    }
}

#Preview {
    fountainUnit()
}
