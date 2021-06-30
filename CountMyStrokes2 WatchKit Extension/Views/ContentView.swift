//
//  ContentView.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModelWatch = ViewModelWatch()
    @State private var didLongPress = false
    var body: some View {
        //        Text(self.viewModelWatch.messageText)
        VStack(alignment: .leading) {
            Text("Score: 100")
            HStack{
                Text("Hole# 18")
                Spacer()
                Text("Strokes: 10")
            }
            HStack{
                Button1(labelText: "General: 10") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
                }
                Button1(labelText: "Chips: 10") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
                }
            }
            Spacer()
            HStack{
                Button1(labelText: "Puts: 10") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
                }
                Button1(labelText: "Penalties: 10") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @ObservedObject var viewModelWatch = ViewModelWatch()
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 6 - 40mm")
    }
}
