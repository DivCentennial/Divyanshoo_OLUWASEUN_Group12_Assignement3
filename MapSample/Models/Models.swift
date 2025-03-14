//
//  Models.swift
//  MapSample
//
//  Created by Divyanshoo Sinha on 2025-03-14.
//

import Foundation
import CoreLocation

// MARK: - Models

struct Restaurant: Identifiable, Hashable {
    let id = UUID()
    
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let name: String
    let typeOfFood: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
