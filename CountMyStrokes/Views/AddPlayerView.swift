//
//  AddPlayerView.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/4/21.
//

import SwiftUI

struct AddPlayerView: View {
    
    @EnvironmentObject var model: WatchConnectivityPhone
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var newPlayerName = ""
    @State private var action: Int? = 0
    
    var body: some View {
        VStack{
            TextField("Player Name:", text: $newPlayerName)

            Button1(label: "Add Player") {
                self.model.objectWillChange.send()
                model.miniGolfGameManager.addPlayer(playerName: newPlayerName)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerView()
    }
}
