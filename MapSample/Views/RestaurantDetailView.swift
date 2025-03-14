//
//  RestaurantDetailView.swift
//  MapSample
//
//  Created by Divyanshoo Sinha on 2025-03-14.
//

import SwiftUI
import CoreLocation

// MARK: - Restaurant Detail View

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    let locationManager: LocationManager
    
    var distanceText: String {
        guard let userLocation = locationManager.userLocation else {
            return "Distance: Unknown"
        }
        
        let restaurantLocation = restaurant.location
        let distanceInMeters = userLocation.distance(from: restaurantLocation)
        
        if distanceInMeters < 1000 {
            return String(format: "Distance: %.0f m", distanceInMeters)
        } else {
            let distanceInKm = distanceInMeters / 1000
            return String(format: "Distance: %.2f km", distanceInKm)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(distanceText)
                .font(.headline)
                .padding(.bottom, 4)
            
            Text(restaurant.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(restaurant.typeOfFood)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            Text("Latitude: \(restaurant.latitude)")
            Text("Longitude: \(restaurant.longitude)")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
