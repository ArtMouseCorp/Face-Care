import UIKit

struct Language {
    
    let name: String
    let image: UIImage
    let code: Code
    
    public static var languages = [
        Language(name: "English",   image: .Flags.uk, code: .en),
        Language(name: "Russian",   image: .Flags.ru, code: .ru),
        Language(name: "French",    image: .Flags.fr, code: .fr),
        Language(name: "German",    image: .Flags.de, code: .de),
        Language(name: "Italian",   image: .Flags.it, code: .it),
        Language(name: "Spanish",   image: .Flags.es, code: .es)
    ]
    
    internal enum Code: String {
        case en, ru, de, fr, es, it
        
        init(_ value: String) {
            switch value.lowercased() {
            case "en": self = .en
            case "ru": self = .ru
            case "fr": self = .fr
            case "de": self = .de
            case "it": self = .it
            case "es": self = .es
            default: self = .en
            }
            
            let currentIndex = languages.firstIndex(where: { language in
                return language.code == self
            })
            
            languages.swapAt(0, currentIndex ?? 0)
        }
        
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
