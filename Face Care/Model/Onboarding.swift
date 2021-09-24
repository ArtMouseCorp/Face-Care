import Foundation

struct Onboarding {
    
    let skinType: SkinType
    let parts: [FacePart]
    let name: String
    let age: Int
    
    enum SkinType: String {
        case normal
        case сombined
        case oily
        case dry
    }
    
    enum FacePart: String, Equatable {
        case eyes
        case forehead
        case neck
        case chin
        case cheekbonesAndCheeks
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
