//
//  ContentView.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var isOnboardingCompleted = false
    
    var body: some View {
        if isOnboardingCompleted{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
        else{
            WelcomePageView(isOnboardingCompleted: $isOnboardingCompleted)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
