//
//  PlantView.swift
//  PlantTracker
//
//  Created by Jackson Dowden on 8/14/21.
//

import SwiftUI

struct PlantView: View {
    
    init(plant: Plant) {
        self.plant = plant
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        }
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @ObservedObject var notificationManager = NotificationManager()
    
    @State var plant: Plant
    
    var body: some View {

        HStack {
            VStack {
                
                TextField("Plant name", text: $plant.name,
                          onCommit: {
                            contentViewModel.setName(plant:plant,name:plant.name)
                          })
                    .padding(/*@START_MENU_TOKEN@*/.all, 5.0/*@END_MENU_TOKEN@*/)
                    .font(Font.title.weight(.heavy))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)

                Text("Water every...")
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    .padding(/*@START_MENU_TOKEN@*/.all, 5.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.white)
                HStack(spacing: 10.0) {
                    
                    Text("\(plant.water) days")
                        .font(.title2)
                        .padding(/*@START_MENU_TOKEN@*/.horizontal, 5.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                    
                    Stepper(
                        onIncrement: {
                            notificationManager.clearNotifications(plant: plant)
                            notificationManager.sendNotification(plant: plant, title: "\(plant.name) needs water!", launchIn: Double(plant.water))
                            contentViewModel.setWater(plant: plant, water: (plant.water+1))},
                        onDecrement: {
                            if plant.water > 1 {
                                notificationManager.clearNotifications(plant: plant)
                                notificationManager.sendNotification(plant: plant, title: "\(plant.name) needs water!", launchIn: Double(plant.water))
                                contentViewModel.setWater(plant: plant, water: (plant.water-1))
                            } else {
                                plant.water = 1
                            }},
                        label: {
                            
                        })
                        .padding(0.0)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .background(Color("DarkGreen"))
                        .labelsHidden()
                        .accentColor(.white)
                        .cornerRadius(10)
                }
                .padding(0.0)
            }
            
            ZStack(alignment: .topTrailing) {
                
                Button(action: {
                    contentViewModel.setPhoto(plant: plant)
                }, label: {
                    if plant.photoChosen {
                        Image(uiImage: plant.plantPhoto)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150.0, height: 150.0)
                            .clipped()
                            .cornerRadius(10)
                    } else {
                        Image(systemName: "camera.fill")
                            .foregroundColor(Color("DarkGreen"))
                    }
                })
                .frame(width: 150.0, height: 150.0)
            
                Image(systemName: "pencil")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            .padding(/*@START_MENU_TOKEN@*/.all, 7.0/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $plant.choosingPhoto) {
                ImagePicker(plantImage: $plant.plantPhoto, sourceType: .camera)
            }
        }
        .frame(width: 375.0)
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("Text"), lineWidth: 2)).background(RoundedRectangle(cornerRadius: 20).fill(Color("CustomGreen")))
    }
}

struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        PlantView(plant: Plant(name:"Jacky", water:3)).environmentObject(ContentViewModel())
    }
}
