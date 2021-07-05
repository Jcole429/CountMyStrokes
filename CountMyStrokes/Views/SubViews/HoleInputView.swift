//
//  HoleInfoUIView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct HoleInputView: View {
    @EnvironmentObject var model: WatchConnectivityPhone
    
    var body: some View {
        VStack() {
            HoleInputSection(
                label: "General: \(model.golfGameManager.getCurrentHole().strokesTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHoleStrokesTaken()
                    model.updateWatchGolf()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHoleStrokesTaken()
                    model.updateWatchGolf()
                })
            HoleInputSection(
                label: "Chips: \(model.golfGameManager.getCurrentHole().chipsTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHoleChipsTaken()
                    model.updateWatchGolf()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHoleChipsTaken()
                    model.updateWatchGolf()
                })
            HoleInputSection(
                label: "Puts: \(model.golfGameManager.getCurrentHole().putsTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHolePutsTaken()
                    model.updateWatchGolf()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHolePutsTaken()
                    model.updateWatchGolf()
                })
            HoleInputSection(
                label: "Penalties: \(model.golfGameManager.getCurrentHole().penaltiesTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHolePenaltiesTaken()
                    model.updateWatchGolf()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHolePenaltiesTaken()
                    model.updateWatchGolf()
                })
            HoleInputSection(
                label: "Green in Regulation:    ",
                button1ImageView: AnyView(Image(systemName: "checkmark.circle").foregroundColor(model.golfGameManager.getCurrentHole().greenInRegulation ?? false ? .green : .white)),
                button1Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.pressedGreenInRegulation()
                },
                button2ImageView: AnyView(Image(systemName: "xmark.circle").foregroundColor(model.golfGameManager.getCurrentHole().greenInRegulation ?? true ? .white : .red)),
                Button2Action: {
                    model.objectWillChange.send()
                    model.golfGameManager.pressedGreenNotInRegulation()
                })
        }
        .foregroundColor(.white)
        .font(.title3)
        .lineLimit(2)
    }
}


struct HoleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.darkGray)
                .cornerRadius(8)
                .opacity(0.5)
            HoleInputView().environmentObject(model)
        }
    }
}

