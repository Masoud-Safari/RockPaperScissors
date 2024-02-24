//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Masoud Safari on 2024-02-24.
//

import SwiftUI

struct Hand {
    let shape: String
    let emoji: String
    let win: String
    let lose: String
}

let rock = Hand(shape: "rock", emoji: "🪨", win: "scissors", lose: "paper")
let paper = Hand(shape: "paper", emoji: "📄", win: "rock", lose: "scissors")
let scissors = Hand(shape: "scissors", emoji: "✂️", win: "paper", lose: "rock")

let choices: [Hand] = [rock, paper, scissors]

struct gameButton: View {
    let label: String
    let tapped: String
    let function: (String) -> Void
    
    var body: some View {
        Button {
            function(tapped)
        } label: {
            Text(label)
                .font(.system(size: 50))
                .padding(20)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 5)
        }
    }
}

struct ContentView: View {
    @State private var appChoice = choices.randomElement()!
    @State private var playerWin: Bool = Bool.random()
    @State private var score = 0
    @State private var showingScore = false
    let numberOfRounds = 5
    @State private var round: Int = 0
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0.5).ignoresSafeArea()
            LinearGradient(stops: [
                .init(color: Color(red: 1, green: 0.2, blue: 0.4), location: 0.0),
                .init(color: Color(red: 1, green: 0.8, blue: 0.0), location: 0.8)
            ], startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Rock Paper Scissors")
                    .foregroundStyle(.black)
                    .font(.title)
                    .padding(15)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                
                Spacer()
                
                Text("Your score: \(score)")
                
                Spacer()
                
                Group {
                    VStack {
                        Text(appChoice.emoji).font(.system(size: 50))
                        
                        playerWin ?
                        Text("Choose to win")
                            .foregroundColor(.green)
                            .font(.title2) :
                        Text("Choose to lose")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                    .padding(40)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
                    
                    Spacer()
                    
                    HStack {
                        gameButton(label: rock.emoji,
                                   tapped: "rock",
                                   function: buttonTapped)
                        gameButton(label: paper.emoji,
                                   tapped: "paper",
                                   function: buttonTapped)
                        gameButton(label: scissors.emoji,
                                   tapped: "scissors",
                                   function: buttonTapped)
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
        .alert("Your score is \(score)", isPresented: $showingScore) {
            Button("Ok", action: resetGame)
        }
    }
    
    func resetGame() {
        score = 0
        round = 0
    }
    
    func buttonTapped(tapped: String) {
        if playerWin {
            if appChoice.lose == tapped {
                score += 1
            }
        } else {
            if appChoice.win == tapped {
                score += 1
            }
        }
        round += 1
        if round == numberOfRounds {
            showingScore = true
        }
        appChoice = choices.randomElement()!
        playerWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
