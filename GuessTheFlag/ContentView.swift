//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dogukan on 02/10/2022.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State var result = false
    @State var resultIsPresented = false
    @State private var countries = allCountries.shuffled()
    @State private var randomCountry = Int.random(in: 0...2)
    @State private var selectedFlag = 0
    @State private var numberOfFlagsGuessed = 0
    @State private var score = 0
    @State private var gameOver = false
    
    let maxGuesses = 8
    
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.796, green: 0.224, blue: 0.102), location: 0.3),
                .init(color: Color(red: 0.161, green: 0.29, blue: 0.804), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Which flag belongs to")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text("\(countries[randomCountry])")
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { i in
                        Button {
                            selectedFlag = i
                            numberOfFlagsGuessed += 1
                            flagTapped()
                            if numberOfFlagsGuessed == maxGuesses {
                                gameOver = true
                            } else {
                                resultIsPresented = true
                            }
                        } label: {
                            FlagImage(image: countries[i].lowercased())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Text("Score")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    
                    Spacer()
                    
                    Text("\(score)\\\\\(numberOfFlagsGuessed)")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(popupMainMessage(), isPresented: $resultIsPresented) {
            Button("Continue") {
                askQuestion()
            }
        } message: {
            if !result {
                Text(popUpSecondaryMessage())
            }
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: newGame)
        } message: {
            Text("Your score is \(score)\\\\\(maxGuesses)")
        }
    }
    
    func randomiseCountry() {
        randomCountry = Int.random(in: 0...2)
    }
    
    func flagTapped() {
        if selectedFlag == randomCountry {
            score += 1
            result = true
        } else {
            result = false
        }
    }
    
    func askQuestion() {
        if result {
            countries.remove(at: randomCountry)
        }
        countries.shuffle()
        randomiseCountry()
    }
    
    func popupMainMessage() -> String {
        if result {
            return "Correct"
        } else {
            return "Incorrect"
        }
    }
    
    func popUpSecondaryMessage() -> String {
        return "The flag you selected is \(countries[selectedFlag])"
    }
    
    func newGame() {
        numberOfFlagsGuessed = 0
        score = 0
        countries = Self.allCountries
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
