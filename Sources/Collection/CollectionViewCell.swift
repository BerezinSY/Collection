import UIKit

open class CollectionViewCell<T>: UICollectionViewCell {
    
    class var id: String { String(describing: Self.self) }
    class var nib: UINib { UINib(nibName: Self.id, bundle: nil) }
    
    open var item: T?
}

