//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dogukan on 02/10/2022.
//

import SwiftUI

struct ContentView: View {
    let countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA"]
    private var randomCountry = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Which flag belongs to")
                    Text("\(countries[randomCountry])")
                }
                .foregroundColor(.white)
            
                ForEach(0..<3) { i in
                    Button {
                        
                    } label: {
                        Image(countries[i].lowercased())
                            .renderingMode(.original)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
