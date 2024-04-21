//  Created by Zablon Charles on 5/28/23.
import SwiftUI


//struct UserStruct: Identifiable {
//    var id = UUID()
//    var firstname: String
//    var lastname: String
//    var notifications: String
//    var avatar: String
//    var cyclechange: String
//    var birthday: String
//    var email: String
//    var aboutme: String
//    var education: String
//    var work: String
//    var images: [String]
//    var likes: [String]
//    var location: [String]
//    var lookingfor: String
//    var online: Bool
//    var password: String
//    var matches: [String]
//   // var nonematches: [String]
//    var age: String
//    var lifestyle: [String]
//    var lifestyledesc: String
//    var lastDateOnline: Date? // Assuming it's a date
//    var zipcode: String
//    var dateJoined: Date
//
//}


//var userStruct = [
//    UserStruct(firstname: "Samantha", lastname: "Doe", notifications: "2", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1064&q=80", cyclechange: "24", birthday: "01/01/1995", email: "johndoed@example.com", aboutme: "I enjoy playing sports and reading books.", education: "University of XYZ", work: "XYZ Corporation", images: ["https://source.unsplash.com/random/?female,friends,beautiful", "https://source.unsplash.com/random/?female,beautiful"], likes: ["Hiking", "Golfing"], location: ["New York"], lookingfor: "Dating", online: true, password: "p@ssw0rd", matches: [""], age: "28", lifestyle: ["Healthy lifestyle"], lifestyledesc: "I follow a healthy lifestyle and focus on eating nutritious food. I'm also passionate about fitness and enjoy running and practicing yoga."),
//    UserStruct(firstname: "Emmason", lastname: "Smith", notifications: "1", avatar: "https://images.unsplash.com/photo-1551184451-76b762941ad6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGJlYXV0eXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60", cyclechange: "12", birthday: "05/12/1992", email: "emmasmith@example.com", aboutme: "I'm a music lover and enjoy painting.", education: "ABC College", work: "ABC Company", images: ["https://source.unsplash.com/random/?female,friends,beautiful", "https://source.unsplash.com/random/?female,beautiful"], likes: ["Like 3"], location: ["Los Angeles"], lookingfor: "Friendship", online: false, password: "pass123", matches: [""], age: "31", lifestyle: ["Active lifestyle"], lifestyledesc: "I lead an active lifestyle and engage in activities like swimming, cycling, and playing tennis."),
//    UserStruct(firstname: "Jessica", lastname: "Johnson", notifications: "3", avatar: "https://images.unsplash.com/photo-1524502397800-2eeaad7c3fe5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGJlYXV0eXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60", cyclechange: "36", birthday: "10/08/1990", email: "michaeljohnson@example.com", aboutme: "I'm a foodie and love to travel.", education: "City College", work: "Tech Startup", images: ["https://source.unsplash.com/random/?female,friends,beautiful", "https://source.unsplash.com/random/?female,beautiful"], likes: ["Like 4", "Like 5"], location: ["London"], lookingfor: "Long-term relationship", online: true, password: "password123", matches: [""], age: "33", lifestyle: ["Yoga and meditation"], lifestyledesc: "I practice yoga and meditation regularly to maintain a balance in life. I'm also an avid traveler and enjoy exploring new cultures and cuisines."),
//    UserStruct(firstname: "Olivia", lastname: "Brown", notifications: "5", avatar: "https://images.unsplash.com/photo-1581182815808-b6eb627a8798?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1530&q=80", cyclechange: "48", birthday: "03/20/1988", email: "oliviabrown@example.com", aboutme: "I love photography and nature.", education: "University of ABC", work: "Design Studio", images: ["https://source.unsplash.com/random/?female,friends,beautiful", "https://source.unsplash.com/random/?female,beautiful"], likes: ["Like 6", "Like 7"], location: ["Paris"], lookingfor: "Casual dating", online: true, password: "qwerty", matches: [""], age: "35", lifestyle: ["Art and culture"], lifestyledesc: "I'm passionate about art and culture. I enjoy visiting art exhibitions and museums, and I also love capturing moments through photography.")
//]


//var userNoStruct = [
//    UserStruct(firstname: "", lastname: "", notifications: "", avatar: "", cyclechange: "24", birthday: "", email: "", aboutme: "", education: "", work: "", images: ["", ""], likes: ["", ""], location: [""], lookingfor: "", online: true, password: "", matches: [""], age: "00", lifestyle: [""], lifestyledesc: "")
//    ]
//
//
//var fakeUser = UserStruct(firstname: "Shania", lastname: "Rossetta", notifications: "8", avatar: "https://images.unsplash.com/photo-1664575602554-2087b04935a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80", cyclechange: "24", birthday: "01/01/1995", email: "johndoe@example.com", aboutme: "I enjoy playing sports and reading books.", education: "University of XYZ", work: "XYZ Corporation", images: ["https://source.unsplash.com/random/?female,friends,beautiful", "https://source.unsplash.com/random/?female,beautiful"], likes: ["Hiking", "Golfing"], location: ["New York"], lookingfor: "Dating", online: true, password: "p@ssw0rd", matches: ["emmasmith@example.com","johndoe@example.com"], age: "28", lifestyle: ["Healthy lifestyle"], lifestyledesc: "I follow a healthy lifestyle and focus on eating nutritious food. I'm also passionate about fitness and enjoy running and practicing yoga.")




var appbackground = BackgroundView()


//----------------------------------------
//new model
// Create a new user
var fakeUser = UserStruct(
    firstName: "Zack",
    lastName: "Benson",
    email:"zack@gmail.com",
    age: 30,
    gender: .female,
    avatar:"https://source.unsplash.com/random/?selfie",
    photos: ["https://source.unsplash.com/random/?selfie", "https://source.unsplash.com/random/?model"],
    occupation: "Software Engineer",
    education: "Bachelor's Degree",
    location: ["United States", "New Jersey", "Jersey City", "07305"],
    coordinates: ["40.728157","-74.077644"],
    bio: "I enjoy hiking, playing guitar, and trying new foods.",
   interests: ["Cooking"],
    lastActive: Date(),
    lookingFor: [.female],
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
        gender: .male,
        avatar:"https://source.unsplash.com/random/?girl",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Software Engineer",
        education: "Bachelor's Degree",
        location: ["United States", "New Jersey", "Jersey City", "07305"],
        coordinates: ["45.086140","-93.258362"],
        bio: "I enjoy hiking, playing guitar, and trying new foods.",
        interests: ["Cooking"],
        lastActive: Date(),
        lookingFor: [.female],
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
    var gender: Gender
    var avatar: String
    var photos: [String]
    var occupation: String
    var education: String
    var location: [String]
    var coordinates: [String]
    var bio: String
    var interests: [String]
    var lastActive: Date
    var lookingFor: [Gender]
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

enum Gender {
    case male
    case female
    case other
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



