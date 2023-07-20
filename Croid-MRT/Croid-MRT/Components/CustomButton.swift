//
//  CustomButton.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var action: () -> Void
    var isBordered: Bool
    var width: Double = .infinity
    var color: Color = .blue
    
    var body: some View {
        if (isBordered) {
            Button(action: action){
                HStack{
                    Spacer()
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                    Text(text)
//                        .frame(maxWidth: width)
                        .foregroundColor(color)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color, lineWidth: 2)
                        )
                    Spacer()
                }
                
            }
            .background(.white)
            .cornerRadius(1000)
        } else {
            Button(action: action) {
                HStack{
                    Spacer()
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                    Text(text)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
//                        .frame(maxWidth: width)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
               
            }
            .background(color)
            .cornerRadius(1000)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Cek Kepadatan Gerbong", action: { print("Button Clicked") }, isBordered: false)
    }
}

