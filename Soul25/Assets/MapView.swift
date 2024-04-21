import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var middleCoordinate: CLLocationCoordinate2D?
    @Binding var coordinates: CLLocationCoordinate2D
    @Binding var cityName: String // Binding for cityName
    
    init(middleCoordinate: Binding<CLLocationCoordinate2D?>, coordinates: Binding<CLLocationCoordinate2D>, cityName: Binding<String>) {
        self._middleCoordinate = middleCoordinate
        self._coordinates = coordinates
        self._cityName = cityName // Initialize the binding for cityName
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Update the map view with new coordinates
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
        
        // Reverse geocode to get city name
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                self.cityName = "Unknown"
                return
            }
            if let city = placemark.locality {
                self.cityName = city
            } else {
                self.cityName = "Unknown"
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            // Calculate the middle coordinate when the map region changes
            let visibleRect = mapView.visibleMapRect
            let visiblePoint = MKMapPoint(x: visibleRect.midX, y: visibleRect.midY)
            let coordinate = visiblePoint.coordinate
            parent.middleCoordinate = coordinate
            parent.coordinates = coordinate // Update coordinates with middleCoordinate
        }
    }
}

struct ContentView: View {
    @State private var middleCoordinate: CLLocationCoordinate2D?
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco coordinates
    @State private var cityName = "" // State variable for cityName
    
    var body: some View {
        VStack {
            MapView(middleCoordinate: $middleCoordinate, coordinates: $coordinates, cityName: $cityName) // Pass cityName as a binding
            if let middleCoordinate = middleCoordinate {
                Text("Middle Coordinate: \(middleCoordinate.latitude), \(middleCoordinate.longitude)")
                Text("City Name: \(cityName)") // Display cityName
            } else {
                Text("Middle Coordinate: Unknown")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
