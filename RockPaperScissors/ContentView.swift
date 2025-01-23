//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Hari's Mac on 10.01.2025.
//

import SwiftUI
struct ContentView: View {
    @State private var content  = ["Rock", "Paper", "Scissors"]
    @State var index = Int.random(in: 0...2)
    @State var playerMove = ""
    @State var point  = 0
    @State private var round = 0
    @State private var showScore = false
    // properties as stated
    @State private var scoretitle = ""
    
    
    var checkWhoWins: Int{
        let playerMoveforNow =  playerMove
        let deviceMoveForNow =  content[index]
        if  deviceMoveForNow == "Rock" {
            if(playerMoveforNow == "Scissors"){
               return -1
                
            }
            else if (playerMoveforNow == "Paper"){
                return 1
            }
        }
        else if deviceMoveForNow == "Paper"{
            if(playerMoveforNow == "Rock"){
             return -1
                
            }
            else if (playerMoveforNow == "Scissors"){
              return 1
            }
        }
        else if deviceMoveForNow == "Scissors"{
            if(playerMoveforNow == "Rock"){
                return 1
            }
            else if(playerMoveforNow == "Paper"){
                return -1
            }
        }
        return 0
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .black]), startPoint: .top, endPoint: .bottom)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack{
                VStack{
                    Section(){
                        Text("Round \(round)")
                    }
                    
                 /*
                    Task - is to remove the next round button so that after selection immediate next round begins
                                                                    */
                    Button("Next Round"){
                        round = round + 1
                        point = point + checkWhoWins
                        askQuestion()
                        if round == 10 {
                            round = 0
                         showScore = true
                        }
                        
                    }
                    
                    Spacer()
                    Section{
                        Text("against \(content[index])")
                            .font(.title)
                        
                    }
            /*
            Bug - all options are randomising without their respective images.
                                                                    */
                    Section{
                        Picker("Player", selection:$playerMove){
                           //Image(systemName: "circle.dashed")
                            ForEach(content, id: \.self){
                                Text($0)
                            }
                          //  Image(systemName: "scissors")
                        }
                        .pickerStyle(.segmented)
                        HStack{
                            Spacer()
                            Image(systemName: "circle.dashed")
                            Spacer()
                            Image(systemName: "rectangle.portrait")
                            Spacer()
                            Image(systemName: "scissors")
                            Spacer()
                        }
                    }
                }

                VStack{
                    Spacer()
                    Section("Points"){
                        Text("\(point)")
                            .font(.title)
                    }
                }
            }
            
        }
        .alert("Game Over", isPresented: $showScore) {
                   Button("OK", role: .cancel) {}
               } message: {
                   Text("Score is \(point)")
               }
    }
  
    func askQuestion(){
        content.shuffle()
       index = Int.random(in:0...2)
    }
}
#Preview {
    ContentView()
}
