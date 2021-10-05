import UIKit

struct Language {
    
    let name: String
    let image: UIImage
    let code: Code
    
    public static var languages: [Language] = {
        
        return [
            Language(name: L.get(key: L.Settings.Language.english),  image: .Flags.uk, code: .en),
            Language(name: L.get(key: L.Settings.Language.russian),  image: .Flags.ru, code: .ru),
            Language(name: L.get(key: L.Settings.Language.french),   image: .Flags.fr, code: .fr),
            Language(name: L.get(key: L.Settings.Language.german),   image: .Flags.de, code: .de),
            Language(name: L.get(key: L.Settings.Language.italian),  image: .Flags.it, code: .it),
            Language(name: L.get(key: L.Settings.Language.spanish),  image: .Flags.es, code: .es)
        ]
    }()
    
    internal enum Code: String, Codable {
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
