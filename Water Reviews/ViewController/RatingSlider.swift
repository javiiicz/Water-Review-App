//
//  RatingSlider.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 3/1/24.
//

import SwiftUI

struct RatingSlider: View {
    private let sliderWidth: CGFloat = 220.0
    private let circleSpacing: CGFloat = 44.0
    
    @State var emoji: String
    @State var type: String
    @Binding var dragOffset: CGFloat
    @Binding var initialDragOffset: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .frame(width: 330, height: 100)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            
            
            VStack {
                HStack{
                    Text("Rate the " + type)
                        .bold()
                        .font(.title3)
                    Text((floor(dragOffset / 20.5)).description)
                        .font(.system(size: 15))
                }
                
                HStack{
                    Text(emoji)
                        .font(.system(size: 40))
                        .transition(.scale)
                    ZStack (alignment: .leading){
                        MyShape().frame(width:230, height:15)
                            .foregroundStyle(Color(.black.opacity(0.1)))
                        MyShape().frame(width: dragOffset + 10, height: 15)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.pink, .yellow]), startPoint: .leading, endPoint: .trailing))
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
                            .onAppear(perform:{
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
