import SwiftUI
import MapKit

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
