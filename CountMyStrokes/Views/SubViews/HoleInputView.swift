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
                    model.updateWatch()
                    model.golfGameManager.decrementCurrentHoleStrokesTaken()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.incrementCurrentHoleStrokesTaken()
                })
            HoleInputSection(
                label: "Chips: \(model.golfGameManager.getCurrentHole().chipsTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.decrementCurrentHoleChipsTaken()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.incrementCurrentHoleChipsTaken()
                })
            HoleInputSection(
                label: "Puts: \(model.golfGameManager.getCurrentHole().putsTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.decrementCurrentHolePutsTaken()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.incrementCurrentHolePutsTaken()
                })
            HoleInputSection(
                label: "Penalties: \(model.golfGameManager.getCurrentHole().penaltiesTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.decrementCurrentHolePenaltiesTaken()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.updateWatch()
                    model.golfGameManager.incrementCurrentHolePenaltiesTaken()
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

