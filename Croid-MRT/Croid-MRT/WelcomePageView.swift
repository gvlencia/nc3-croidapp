//
//  WelcomePageView.swift
//  Croid-MRT
//
//  Created by Michael Christopher on 17/07/23.
//

import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        VStack{
            Spacer()
            Group{
                Text("CRO")
                    .foregroundColor(Color(red: 0, green: 0.34, blue: 0.72))
                    .fontWeight(.heavy)
                    .font(.system(size: 40)) +
                Text("ID")
                    .foregroundColor(Color(red: 0.27, green: 0.73, blue: 0.24))
                    .fontWeight(.heavy)
                    .font(.system(size: 40))
            }
            Text("Ketahui Kepadatan Gerbong MRT Anda")
                .font(.system(size: 15))
                .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
            Spacer()
            Image("placeholder")
            Text("Jadikan #UbahJakarta lebih nyaman dan aman dengan mengetahui tingkat keramaian MRT anda")
                .font(.system(size:12))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.4))
                .frame(width: 285, alignment: .top)
            Spacer()
            Spacer()
            Button {
                
            } label: {
                Label("Cek Keramaian Sekarang", systemImage: "paperplane.fill")
                    .padding()
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .frame(width: 346)
                    .foregroundColor(.white)
                    .background(Color(red: 0, green: 0.34, blue: 0.72))
                    .clipShape(
                        Capsule()
                    )
            }.padding(.bottom, 52)
            
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
