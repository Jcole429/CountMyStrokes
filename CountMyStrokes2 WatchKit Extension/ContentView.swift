//
//  ContentView.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModelWatch = ViewModelWatch()
    var body: some View {
        Text(self.viewModelWatch.messageText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
