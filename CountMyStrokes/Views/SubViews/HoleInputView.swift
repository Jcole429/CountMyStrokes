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
                label: "General: \(model.gameManager.getCurrentHole().strokesTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHoleStrokesTaken()
                    model.updateWatch()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleStrokesTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Chips: \(model.gameManager.getCurrentHole().chipsTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHoleChipsTaken()
                    model.updateWatch()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleChipsTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Puts: \(model.gameManager.getCurrentHole().putsTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHolePutsTaken()
                    model.updateWatch()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHolePutsTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Penalties: \(model.gameManager.getCurrentHole().penaltiesTaken)"
                ,button1ImageView: AnyView(Image(systemName: "minus"))
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHolePenaltiesTaken()
                    model.updateWatch()
                },button2ImageView: AnyView(Image(systemName: "plus"))
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHolePenaltiesTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Green in Regulation:    ",
                button1ImageView: AnyView(Image(systemName: "checkmark.circle").foregroundColor(model.gameManager.getCurrentHole().greenInRegulation ?? false ? .green : .white)),
                button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.pressedGreenInRegulation()
                },
                button2ImageView: AnyView(Image(systemName: "xmark.circle").foregroundColor(model.gameManager.getCurrentHole().greenInRegulation ?? true ? .white : .red)),
                Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.pressedGreenNotInRegulation()
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

