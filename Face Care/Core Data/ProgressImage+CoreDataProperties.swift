import UIKit
import CoreData


extension ProgressImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgressImage> {
        return NSFetchRequest<ProgressImage>(entityName: "ProgressImage")
    }

    @NSManaged public var image: UIImage?

}

extension ProgressImage : Identifiable {

}
