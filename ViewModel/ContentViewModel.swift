//
//  ContentViewModel.swift
//  PlantTracker
//
//  Created by Jackson Dowden on 8/14/21.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    var notificationManager = NotificationManager()
    @Published var plants: [Plant] = []
    
    init() {
        getPlants()
    }
    
    func addPlant() {
        plants.append(Plant(name:"",water:1))
        notificationManager.sendNotification(plant: plants[plants.count-1], title: "\(plants[plants.count-1].name) needs water!", launchIn: Double(plants[plants.count-1].water))
        savePlants()
    }
    
    func deletePlant(at offsets: IndexSet) {
        
        let ids = offsets
        ids.forEach { index in
            notificationManager.clearNotifications(plant: plants[index])
        }
        plants.remove(atOffsets: offsets)
        savePlants()
    }
    
    func savePlants() {
        if let encodedPlants = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(encodedPlants, forKey: "plantKey")
        }
    }
    
    func getPlants() {
        guard
            let data = UserDefaults.standard.data(forKey: "plantKey"),
            let savedPlants = try? JSONDecoder().decode([Plant].self, from: data)
        else { return }
        
        self.plants = savedPlants
    }
    
    func setName(plant: Plant, name: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant.updateName(new_name: name)
        }
        savePlants()
    }
    
    func setWater(plant: Plant, water: Int) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant.updateWater(new_water: water)
        }
        savePlants()
    }
    
    func setPhoto(plant:Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant.updatePhoto()
        }
        savePlants()
    }
}
