//
//  Landmark.swift
//  Landmarks
//
//  Created by pandora on 2020/07/26.
//  Copyright © 2020 pandora. All rights reserved.
//

import CoreLocation
import SwiftUI

struct Landmark: Codable, Hashable, Identifiable {
    var name: String
    var category: Category
    var city: String
    var state: String
    var id: Int
    var park: String
    var coordinates: Coordinates
    var imageName: String
    var locationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Codable, Hashable {
        var latitude: Double
        var longitude: Double
    }
    
    enum Category: String, Codable, Hashable, CaseIterable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
    }
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
