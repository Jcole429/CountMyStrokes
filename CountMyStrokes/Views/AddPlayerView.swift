//
//  AddPlayerView.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/4/21.
//

import SwiftUI

struct AddPlayerView: View {
    
    @EnvironmentObject var model: WCPhone
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var newPlayerName = ""
    @State private var action: Int? = 0
    
    var body: some View {
        ZStack {
            Color.clear.overlay(
                Image("golf-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            ).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    TextField("Player Name:", text: $newPlayerName)
                        .padding()
                }
                .background(Color(.darkGray)
                                .opacity(0.7)
                                .cornerRadius(8))
                .padding()
                Button1(label: "Add Player") {
                    if ($newPlayerName.wrappedValue != "") {
                        self.model.objectWillChange.send()
                        model.miniGolfGameManager.addPlayer(playerName: newPlayerName)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Golf Vectors by Vecteezy")
                        .padding(.trailing)
                        .foregroundColor(.white)
                    
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView()
    }
}
