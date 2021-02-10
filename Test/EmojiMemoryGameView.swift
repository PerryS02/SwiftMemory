//
//  EmojiMemoryGameView.swift
//  Test
//
//  Created by Perry Sykes on 1/7/21.
//

//View

import SwiftUI

//The view for ViewModel emojiMemoryGame
struct EmojiMemoryGameView: View {
    //This is where you declare your ViewModel
    @ObservedObject var viewModel: EmojiMemoryGame
    
    //computed var body, returns a View
    //  Wrap body in a GeometryReader
    //      VStack to arrange Text, Grid and HStack vertically:
    //          Text to display theme name, accessed through function 'themeName' in VM
    //          Create a Grid struct passing in the 'cards' array from VM and a CardView
    //          When a CardView is tapped, call .choose in VM and pass in 'card' tapped
    //          apply padding of 5 to all views within Grid
    //      apply foregroundColor of cardColor from VM, apply padding to all elements in VStack
    //      HStack to arrange 2 ZStacks horizontally:
    //          ZStack consisting of roundedRectangles to display the score from VM
    //          ZStack consisting of roundedRectangles to act as "New Game" button
    //      apply foregroundColor of black to every view in HStack, font of largeTitle, and padding
    var body: some View {
        GeometryReader(content: { geometry in
            VStack() {
                Text("\(viewModel.themeName)").padding(.top).frame(maxHeight: geometry.size.height * 0.05).font(Font.largeTitle).padding(.top)
                Grid(items: viewModel.cards) {card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }.padding(5)
                }.padding()
                HStack() {
                    ZStack() {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                        Text("\(viewModel.score)")
                    }.frame(maxHeight: geometry.size.height * 0.2)
                    ZStack() {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                        Text("New Game")
                    }.frame(minWidth: geometry.size.width * 0.6, maxHeight: geometry.size.height * 0.2).onTapGesture {
                        viewModel.newGame()
                    }
                }.font(Font.largeTitle).padding()
            }.foregroundColor(Color.init(.sRGB, red: viewModel.cardRGB[R], green: viewModel.cardRGB[G], blue: viewModel.cardRGB[B], opacity: 1.0))
        })
    }
    
    // MARK: -Body Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 5
    private let R: Int = 0
    private let G: Int = 1
    private let B: Int = 2
}


//Struct CardView, returns a View of one card
//  var card of a Card struct from Model
//  var body returns some View,
//      if 'card' is face up or card is not matched
//          Wrap in GeometryReader
//              ZStack of Pie shape, Text of 'card' content
//              .cardify extends View, send in 'card' isFaceUp value to modify CardView to reflect isFaceUp of 'card'
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        if card.isFaceUp || !card.isMatched {
            GeometryReader(content: {geometry in
                ZStack() {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.5)
                        Text(card.content)
                }.cardify(isFaceUp: card.isFaceUp).font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
            })
        }
    }
    
    // MARK: -Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.7
    private let aspectRatio: CGFloat = 2/3
}

//for preview in Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
