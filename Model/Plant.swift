//
//  Plant.swift
//  PlantTracker
//
//  Created by Jackson Dowden on 8/14/21.
//

import Foundation
import UIKit

struct Plant: Identifiable, Hashable, Codable {
    let id: String
    var name: String
    var water: Int
    var photoChosen: Bool
    var choosingPhoto: Bool
    var plantPhoto: UIImage
    
    
    private enum CodingKeys: String, CodingKey {
        case id, name, water, photoChosen, choosingPhoto, plantPhoto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        water = try container.decode(Int.self, forKey: .water)
        photoChosen = try container.decode(Bool.self, forKey: .photoChosen)
        choosingPhoto = false
        let plantData = try container.decode(Data.self, forKey: .plantPhoto)
        guard let plantPhoto = UIImage(data: plantData) else {
            self.plantPhoto = UIImage(imageLiteralResourceName: "plant")
            return
        }
        self.plantPhoto = plantPhoto
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(water, forKey: .water)
        try container.encode(photoChosen, forKey: .photoChosen)
        try container.encode(choosingPhoto, forKey: .choosingPhoto)
        let plantData = plantPhoto.jpegData(compressionQuality: 0.1)
        try container.encode(plantData, forKey: .plantPhoto)
    }
    
    init(id: String = UUID().uuidString, name: String, water: Int, photoChosen: Bool = false, choosingPhoto: Bool = false, plantPhoto: UIImage = UIImage(imageLiteralResourceName: "plant")) {
        self.id = id
        self.name = name
        self.water = water
        self.photoChosen = photoChosen
        self.choosingPhoto = choosingPhoto
        self.plantPhoto = plantPhoto
    }
    
    func updateName(new_name: String) -> Plant {
        return Plant(id: id, name: new_name, water: water, photoChosen: photoChosen, choosingPhoto: choosingPhoto, plantPhoto: plantPhoto)
    }
    
    func updateWater(new_water: Int) -> Plant {
        return Plant(id: id, name: name, water: new_water, photoChosen: photoChosen, choosingPhoto: choosingPhoto, plantPhoto: plantPhoto)
    }
    
    func updatePhoto() -> Plant {
        return Plant(id: id, name: name, water: water, photoChosen: true, choosingPhoto: true)
    }
}
