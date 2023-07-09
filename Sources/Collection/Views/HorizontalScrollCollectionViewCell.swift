import UIKit

open class HorizontalScrollCollectionViewCell<T>: CollectionViewCell<T> {
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        setNeedsLayout()
//        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
