//
//  RandomUser.swift
//  Soul25
//
//  Created by Zablon Charles on 4/19/24.
//

import SwiftUI

// Step 1: Create Swift model structures
// Define structs to match the JSON structure
struct UserResponse: Codable {
    let results: [UserResult]
}

struct UserResult: Codable {
    let gender: String
    let name: UserName
    let location: Location
    let email: String
    let dob: DOB
    let registered: Registered
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String
    
    // Add other properties as needed
}

struct UserName: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable {
    let offset: String
    let description: String
}



struct DOB: Codable {
    let date: String
    let age: Int
}

struct Registered: Codable {
    let date: String
    let age: Int
}



struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
// Step 2: Fetch JSON data and decode it
// Fetch and parse JSON data from the API
func fetchUserData(parameter: String, completion: @escaping ([UserStruct]?) -> Void) {
    guard let url = URL(string: parameter.isEmpty ? "https://randomuser.me/api/?gender=female&results=10" : parameter) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            let users = userResponse.results.map { result in
               
                UserStruct(
                    firstName: result.name.first,
                    lastName: result.name.last,
                    email:"fakeemail@gmail.com",
                    age: 30,
                    gender: .female,
                    avatar:"https://source.unsplash.com/random/?woman+selfie",
                    photos: ["https://source.unsplash.com/random/?girl+woman+friends+candid", "https://source.unsplash.com/random/?girl+photography"],
                    occupation: "Software Engineer",
                    education: "Bachelor's Degree",
                    location: [result.location.country,result.location.state,result.location.city],
                    coordinates: [result.location.coordinates.latitude,result.location.coordinates.longitude],
                    bio: "I enjoy hiking, playing guitar, and trying new foods.",
                    interests: ["Cooking"],
                    lastActive: Date(),
                    lookingFor: [.female],
                    hometown: "result.city",
                    relationshipStatus: .single,
                    height: .average,
                    ethnicity: .white,
                    religion: "Atheist",
                    politicalAffiliation: "Independent",
                    smokingHabit: .nonSmoker,
                    drinkingHabit: .socialDrinker,
                    exerciseFrequency: .regularly,
                    children: .noChildren,
                    pets: .hasPets,
                    dateJoined: Date(),
                    matched:[""],
                    unmatched:[""],
                    liked:[""],
                    prompts:.other
                    
                )
            }
            completion(users)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }.resume()
}
