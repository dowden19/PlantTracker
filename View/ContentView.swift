//
//  ContentView.swift
//  PlantTracker
//
//  Created by Jackson Dowden on 8/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @ObservedObject var notificationManager = NotificationManager()

    var body: some View {
        
        VStack {
            Text("PlantTracker")
                .fontWeight(.heavy)
                .padding(10)
                .foregroundColor(Color("CustomGreen"))
                .font(.largeTitle)
                
            List {
                ForEach(contentViewModel.plants, id:\.self) { plant in
                    PlantView(plant: plant)
                }.onDelete(perform: contentViewModel.deletePlant)
            }
            HStack {
                
                Button(action: {
                    contentViewModel.addPlant()
                }, label: {
                    HStack{
                        Image(systemName: "plus")
                            .padding([.top, .leading, .bottom], 13.0)
                            .foregroundColor(Color.white)
                            
                        Text("Add new plant")
                            .padding([.top, .bottom, .trailing], 13.0)
                            .foregroundColor(Color.white)
                            .font(.title2)
                            
                    }.overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color("Text"), lineWidth: 1)).background(RoundedRectangle(cornerRadius: 40).fill(Color("CustomGreen")))
                    
                })
                /*Button(action: {
                    notificationManager.clearAll()
                }, label: {
                    Text("Clear")
                })*/
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ContentViewModel())
    }
}
