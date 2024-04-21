//
//  NearMeProfilesCards.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//
import CoreLocation
import SwiftUI

struct NearMeProfilesCards: View {
    @State var profiles: [UserStruct] = []
    @State private var filteredProfiles: [UserStruct] = []
    @State var currentUser: UserStruct? = fakeUser
    @State var profile = fakeUsers[0]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func nearMeFunc() {
        guard let currentUser = currentUser else {
            filteredProfiles = profiles
            return
        }
        
        let matchingEmails = Set(currentUser.matched)
        let currentUserLocation = currentUser.location // Assuming you have the
        filteredProfiles = filteredProfiles.filter { prof in
            guard let profileCoordinates = parseCoordinates(prof.coordinates),
                  let currentUserCoordinates = parseCoordinates(fakeUser.coordinates) else {
                return false
            }
            
            let locationA = CLLocation(latitude: profileCoordinates.latitude, longitude: profileCoordinates.longitude)
            let locationB = CLLocation(latitude: currentUserCoordinates.latitude, longitude: currentUserCoordinates.longitude)
            
            let distanceInMeters = locationA.distance(from: locationB)
            let distanceInMiles = distanceInMeters * 0.000621371 // Convert distance to miles
            
            // Assuming a threshold distance of 5000 miles (adjust as needed)
            return distanceInMiles <= 200
        }
    }
    // Function to parse coordinates from array of strings to double
    func parseCoordinates(_ coordinates: [String]) -> (latitude: Double, longitude: Double)? {
        guard coordinates.count == 2,
              let latitude = Double(coordinates[0]),
              let longitude = Double(coordinates[1]) else {
            return nil
        }
        return (latitude: latitude, longitude: longitude)
    }
    
    // Function to calculate distance between two locations
    func calculateDistance(_ locationA: CLLocation, _ locationB: CLLocation) -> CLLocationDistance {
        return locationA.distance(from: locationB)
    }
    func calculateDistance(coordinatesA: (latitude: Double, longitude: Double), coordinatesB: (latitude: Double, longitude: Double)) -> CLLocationDistance {
        let locationA = CLLocation(latitude: coordinatesA.latitude, longitude: coordinatesA.longitude)
        let locationB = CLLocation(latitude: coordinatesB.latitude, longitude: coordinatesB.longitude)
        return locationA.distance(from: locationB)
    }
    
    
}

struct NearMeProfilesCards_Previews: PreviewProvider {
    static var previews: some View {
        NearMeProfilesCards()
    }
}
