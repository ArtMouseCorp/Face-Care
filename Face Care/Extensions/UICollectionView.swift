import UIKit

extension UICollectionView {
    
    func registerCell(cell: Cell) {
        self.register(cell.nib, forCellWithReuseIdentifier: cell.rawValue)
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
