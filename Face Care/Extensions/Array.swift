import UIKit

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
    func random(elements n: Int) -> [Element] {
        
        var randoms: [Element] = []
        
        while randoms.count != n {
            if let randomElement = self.randomElement() {
                randoms.append(randomElement)
                randoms.removeDuplicates()
            }
        }
        
        return randoms
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
