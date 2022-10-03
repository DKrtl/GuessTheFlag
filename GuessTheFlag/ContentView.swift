//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dogukan on 02/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State var result = ""
    @State var resultIsPresented = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var randomCountry = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Which flag belongs to")
                        .font(.subheadline.weight(.heavy))
                    Text("\(countries[randomCountry])")
                        .font(.largeTitle.weight(.semibold))
                }
                .foregroundColor(.white)
            
                ForEach(0..<3) { i in
                    Button {
                        resultIsPresented = true
                        flagTapped(i)
                    } label: {
                        Image(countries[i].lowercased())
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
            .padding()
        }
        .alert(result, isPresented: $resultIsPresented) {
            Button("Continue") {
                askQuestion()
            }
        } message: {
            Text("Your score is ???")
        }
    }
    
    func randomiseCountry() {
        randomCountry = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        resultIsPresented = true
        
        if number == randomCountry {
            result = "Correct"
        } else {
            result = "Incorrect"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        randomiseCountry()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
