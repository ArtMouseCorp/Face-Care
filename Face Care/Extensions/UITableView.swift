import UIKit

extension UITableView {
    
    func registerCell(cell: Cell) {
        self.register(cell.nib, forCellReuseIdentifier: cell.rawValue)
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
