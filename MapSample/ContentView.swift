import SwiftUI
import MapKit
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

// MARK: - Location Manager

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location
        }
    }
}

// MARK: - Restaurant Model

class RestaurantModel: ObservableObject {
    let bakeries = [
        Restaurant(latitude: 43.6532, longitude: -79.3832, name: "Charlie's Chocolate Factory 🍫", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6645, longitude: -79.4125, name: "Cake Island 🎂", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6578, longitude: -79.3762, name: "Lucknow Sweets 🍡", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6421, longitude: -79.4100, name: "Alibaba 40 Sweets 🍮", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6692, longitude: -79.3915, name: "Dodo Donuts 🍩", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6428, longitude: -79.3789, name: "Meta Muffin 🧁", typeOfFood: "Bakery")
    ]
    
    let mexicanRestaurants = [
        Restaurant(latitude: 43.6512, longitude: -79.3752, name: "Div Diablo 😈", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6445, longitude: -79.4025, name: "Orlando Kitchen 🍽️", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6578, longitude: -79.3902, name: "MEDUOYE Dining 🍴", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6421, longitude: -79.3850, name: "Gambit Burritos 🌯", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6582, longitude: -79.4105, name: "El Loco de Tacos 🌮", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6478, longitude: -79.3769, name: "Escobar Eatery 🧑🏽‍🍳", typeOfFood: "Mexican")
    ]
}

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

// MARK: - Content View

struct ContentView: View {
    @StateObject var model = RestaurantModel()
    @StateObject var locationManager = LocationManager()
    
    @State var cameraPosition = MapCameraPosition.automatic
    @State var selection: Restaurant?
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selection) {
            // Add bakeries as markers
            ForEach(model.bakeries) { bakery in
                Marker(bakery.name,
                       systemImage: "birthday.cake",
                       coordinate: bakery.coordinate)
                .tag(bakery)
            }
            
            // Add Mexican restaurants as custom annotations
            ForEach(model.mexicanRestaurants) { restaurant in
                // Use Annotation instead of MapAnnotation for taggable content
                Annotation(restaurant.name, coordinate: restaurant.coordinate, anchor: .center) {
                    Text(verbatim: "🇲🇽")
                        .padding(2)
                        .background(Color.black.opacity(0.4), in: Circle())
                }
                .tag(restaurant)
            }
            
            // Add user location
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
        }
        .onChange(of: selection) { _, newValue in
            if let newValue {
                withAnimation {
                    cameraPosition = .camera(
                        MapCamera(
                            centerCoordinate: newValue.coordinate,
                            distance: 500,
                            heading: 0,
                            pitch: 0
                        )
                    )
                }
            }
        }
        .sheet(item: $selection) { restaurant in
            RestaurantDetailView(restaurant: restaurant, locationManager: locationManager)
                .presentationDetents([.fraction(0.25)])
                .presentationBackgroundInteraction(.enabled)
        }
        .task {
            locationManager.requestLocationPermission()
        }
    }
}

#Preview {
    ContentView()
}
