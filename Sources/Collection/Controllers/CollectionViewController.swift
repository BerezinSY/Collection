import UIKit

open class CollectionViewController<
    T: CollectionModel,
    Header: CollectionReusableView<T.Header>,
    Cell: CollectionViewCell<T.Item>>: UICollectionViewController {
    
    public var content: [T] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    open var estimatedItemSize: CGSize {
        CGSize(width: 50, height: 50)
    }
    
    open var headerReferenceSize: CGSize {
        .zero
    }
    
    open var minimumLineSpacing: CGFloat {
        10
    }
    
    open var minimumInteritemSpacing: CGFloat {
        10
    }
    
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
        collectionViewFlowLayout?.estimatedItemSize = estimatedItemSize
        collectionViewFlowLayout?.minimumLineSpacing = minimumLineSpacing
        collectionViewFlowLayout?.headerReferenceSize = headerReferenceSize
        collectionViewFlowLayout?.minimumInteritemSpacing = minimumInteritemSpacing
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
}
