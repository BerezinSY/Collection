import UIKit

open class CollectionViewController<
    T: CollectionModel,
    Header: CollectionReusableView<T.Header>,
    Cell: CollectionViewCell<T.Item>>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    public var content: [T] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    open var layoutModel: LayoutModel { CollectionLayoutModel() }
    open var layoutModelWithSection: LayoutModel { CollectionLayoutModel() }
    open var layoutModelWithoutSection: LayoutModel { CollectionLayoutModel() }
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout? {
        collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    public required init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.backgroundColor = UIColor.clear.cgColor
        collectionView.register(Cell.nib, forCellWithReuseIdentifier: Cell.id)
        collectionView.register(
            Header.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Header.id
        )
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewFlowLayout?.estimatedItemSize = layoutModel.estimatedItemSize
    }
    
    // MARK: UICollectionViewDataSource
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        content.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content[section].items.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.id, for: indexPath) as? Cell
        let item = content[indexPath.section].items[indexPath.item]
        cell?.item = item
        return cell ?? UICollectionViewCell()
    }
    
    open override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard content[indexPath.section].isShowHeader else { return UICollectionReusableView() }
        let item = content[indexPath.section].header
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.id, for: indexPath) as? Header
        view?.item = item
        return view ?? UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard content[section].isShowHeader else { return layoutModelWithoutSection.insetForSection(at: section) }
        return layoutModelWithSection.insetForSection(at: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard content[section].isShowHeader else { return layoutModelWithoutSection.referenceSizeForHeader(in: section) }
        return layoutModelWithSection.referenceSizeForHeader(in: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        layoutModel.minimumLineSpacingForSection(for: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard content[section].isShowFooter else { return layoutModelWithoutSection.referenceSizeForFooter(in: section) }
        return layoutModelWithSection.referenceSizeForFooter(in: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        layoutModel.minimumInteritemSpacing(for: section)
    }
}
