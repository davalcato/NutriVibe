//
//  ContentView.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to NutriVibe!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Your health companion starts here.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
