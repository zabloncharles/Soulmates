//  Created by Zablon Charles on 5/28/23.
import SwiftUI


var appbackground = BackgroundView()


//----------------------------------------
//new model
// Create a new user
var fakeUser = UserStruct(
    firstName: "Zack",
    lastName: "Benson",
    email:"zack@gmail.com",
    age: 30,
    gender: "male",
    avatar:"https://source.unsplash.com/random/?selfie",
    photos: ["https://source.unsplash.com/random/?selfie", "https://source.unsplash.com/random/?model"],
    occupation: "Software Engineer",
    education: "Bachelor's Degree",
    location: ["United States", "New Jersey", "Jersey City", "07305"],
    coordinates: ["40.728157","-74.077644"],
    bio: "I enjoy hiking, playing guitar, and trying new foods.",
   interests: ["Cooking"],
    lastActive: Date(),
    lookingFor: "female",
    hometown: "Chicago",
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
    matched:["fakeemail@gmail.com","emmasmith@example.com","johndoe@example.com"],
    unmatched:[""],
    liked:[""],
    prompts:.other
)

var fakeUsers: [UserStruct] = [
    UserStruct(
        firstName: "Fake",
        lastName: "User",
        email:"emmasmith@example.com",
        age: 30,
        gender: "female",
        avatar:"https://source.unsplash.com/random/?girl",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Software Engineer",
        education: "Bachelor's Degree",
        location: ["United States", "New Jersey", "Jersey City", "07305"],
        coordinates: ["45.086140","-93.258362"],
        bio: "I enjoy hiking, playing guitar, and trying new foods.",
        interests: ["Cooking"],
        lastActive: Date(),
        lookingFor: "female",
        hometown: "Chicago",
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
]



struct UserStruct {
    var id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var gender: String
    var avatar: String
    var photos: [String]
    var occupation: String
    var education: String
    var location: [String]
    var coordinates: [String]
    var bio: String
    var interests: [String]
    var lastActive: Date
    var lookingFor: String
    var hometown: String
    var relationshipStatus: RelationshipStatus
    var height: Height
    var ethnicity: Ethnicity
    var religion: String
    var politicalAffiliation: String
    var smokingHabit: SmokingHabit
    var drinkingHabit: DrinkingHabit
    var exerciseFrequency: ExerciseFrequency
    var children: ChildrenStatus
    var pets: PetsStatus
    var dateJoined: Date
    var matched: [String]
    var unmatched: [String]
    var liked: [String]
    var prompts: Prompts

}


enum Prompts {
    case quote
    case opinion
    case other
}

enum RelationshipStatus {
    case single
    case inARelationship
    case married
    case divorced
    case widowed
}

enum Height {
    case short
    case average
    case tall
}

enum Ethnicity {
    case asian
    case black
    case latino
    case white
    case other
}

enum SmokingHabit {
    case nonSmoker
    case socialSmoker
    case regularSmoker
}

enum DrinkingHabit {
    case nonDrinker
    case socialDrinker
    case regularDrinker
}

enum ExerciseFrequency {
    case rarely
    case occasionally
    case regularly
}

enum ChildrenStatus {
    case noChildren
    case wantChildren
    case haveChildren
}

enum PetsStatus {
    case hasPets
    case noPets
}



