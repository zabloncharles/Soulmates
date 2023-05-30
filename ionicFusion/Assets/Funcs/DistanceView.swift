//
//  DistanceView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/24/23.
//

import SwiftUI
import CoreLocation

struct DistanceView: View {
    @State private var distance: CLLocationDistance?
    let destinationAddress = "1600 Amphitheatre Parkway, Mountain View, CA" // Replace with the address you want to calculate the distance to
    
    var body: some View {
        VStack {
            if let distance = distance {
                Text("\(convertMetersToMiles(distance)) miles away")
            } else {
                Text("Calculating distance...")
            }
        }
        .onAppear {
            calculateDistance()
        }
    }
    
    private func calculateDistance() {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(destinationAddress) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first,
                  let destinationLocation = placemark.location else {
                print("No placemark or location found.")
                return
            }
            
            let currentLocation = CLLocation(latitude: 45.110290, longitude: -93.276989) // Replace with your current location coordinates
            
            let distance = currentLocation.distance(from: destinationLocation)
            
            self.distance = distance
        }
    }
    
    private func convertMetersToMiles(_ meters: CLLocationDistance) -> Int {
        let metersPerMile: Double = 1609.34
        let miles = meters / metersPerMile
        return Int(round(miles))
    }
}
