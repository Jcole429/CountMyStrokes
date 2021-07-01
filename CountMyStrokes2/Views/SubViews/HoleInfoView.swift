//
//  HoleInfoUIView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct HoleInfoView: View {
    @EnvironmentObject var model: ViewModelPhone
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Hole #\(model.gameManager.getCurrentHole().holeNumber)")
            Text("Hole Strokes: \(model.gameManager.getCurrentHole().totalStrokesTaken)")
            HoleInputSection(
                label: "General: \(model.gameManager.getCurrentHole().strokesTaken)"
                ,button1Image: Image(systemName: "minus")
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHoleStrokesTaken()
                    model.updateWatch()
                },button2Image: Image(systemName: "plus")
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleStrokesTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Chips: \(model.gameManager.getCurrentHole().chipsTaken)"
                ,button1Image: Image(systemName: "minus")
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHoleChipsTaken()
                    model.updateWatch()
                },button2Image: Image(systemName: "plus")
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleChipsTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Puts: \(model.gameManager.getCurrentHole().putsTaken)"
                ,button1Image: Image(systemName: "minus")
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHolePutsTaken()
                    model.updateWatch()
                },button2Image: Image(systemName: "plus")
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHolePutsTaken()
                    model.updateWatch()
                })
            HoleInputSection(
                label: "Penalties: \(model.gameManager.getCurrentHole().penaltiesTaken)"
                ,button1Image: Image(systemName: "minus")
                ,button1Action: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHolePenaltiesTaken()
                    model.updateWatch()
                },button2Image: Image(systemName: "plus")
                ,Button2Action: {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHolePenaltiesTaken()
                    model.updateWatch()
                })
            EqualCenter(firstView: AnyView(Text("Green in Regulation:")), secondView: AnyView(
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "checkmark.circle")
                    }.padding(.horizontal, 10)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "xmark.circle")
                    }.padding(.horizontal, 10)
                }
            ))
        }
        .padding(.horizontal, 50)
        .foregroundColor(.white)
        .font(.title3)
    }
}


struct HoleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.darkGray)
                .cornerRadius(8)
                .opacity(0.5)
                .padding(.horizontal, 30)
            HoleInfoView().environmentObject(model)
        }
    }
}

