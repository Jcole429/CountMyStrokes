//
//  MainMenuView.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var model: WatchConnectivityPhone
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.overlay(
                    Image("golf-background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                ).edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(
                        destination: PhoneGolfView().environmentObject(model),
                        label: {
                            Text("Golf Mode")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color(UIColor.systemGreen))
                                .cornerRadius(8)
                        }).isDetailLink(false)
                    NavigationLink(
                        destination: PhoneMiniGolfView().environmentObject(model),
                        label: {
                            Text("Mini Golf Mode\n(Coming Soon)")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color(UIColor.systemGreen))
                                .cornerRadius(8)
                        }).isDetailLink(false).disabled(true).grayscale(0.8)
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Golf Vectors by Vecteezy")
                            .padding(.trailing)
                            .foregroundColor(.white)
                        
                    }
                }
            }
            .navigationBarTitle("CountMyStrokes")
            .foregroundColor(.black)
            
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView().environmentObject(model)
    }
}
