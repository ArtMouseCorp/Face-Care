import UIKit

public enum Cell: String {
    
    // Main
    case dailyTraining      = "DailyTrainingCollectionViewCell"
    case exclusiveTraining  = "ExclusiveTrainingCollectionViewCell"
    case exercise           = "ExerciseTableViewCell"
    
    // Progress
    
    // Atricles
    case article            = "ArticleTableViewCell"
    
}

extension Cell {
    var id: String {
        return self.rawValue
    }
    
    var nib: UINib {
        return UINib(nibName: self.id, bundle: nil)
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
