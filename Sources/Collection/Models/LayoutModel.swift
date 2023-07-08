import UIKit

public protocol LayoutModel {
    func sizeForItem(at indexPath: IndexPath) -> CGSize
    func insetForSection(at section: Int) -> UIEdgeInsets
    func referenceSizeForHeader(in section: Int) -> CGSize
    func referenceSizeForFooter(in section: Int) -> CGSize
    func minimumInteritemSpacing(for section: Int) -> CGFloat
    func minimumLineSpacingForSection(for section: Int) -> CGFloat
}

public extension LayoutModel {
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 50)
    }
    
    func insetForSection(at section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func referenceSizeForHeader(in section: Int) -> CGSize {
        .zero
    }
    
    func referenceSizeForFooter(in section: Int) -> CGSize {
        .zero
    }
    
    func minimumInteritemSpacing(for section: Int) -> CGFloat {
        10
    }
    
    func minimumLineSpacingForSection(for section: Int) -> CGFloat {
        10
    }
}
