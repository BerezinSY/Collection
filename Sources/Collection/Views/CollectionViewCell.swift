import UIKit

open class CollectionViewCell<T>: UICollectionViewCell {
    
    open class var id: String { String(describing: Self.self) }
    open class var nib: UINib { UINib(nibName: Self.id, bundle: nil) }
    
    open var item: T?
    
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        return layoutAttributes
    }
}

