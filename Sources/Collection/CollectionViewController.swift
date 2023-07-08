import UIKit

open class CollectionViewController<
    T: CollectionModel,
    Cell: CollectionViewCell<T.Item>>: UICollectionViewController {
    
    public var content: [T] = [] {
        didSet {
            collectionView?.reloadData()
        }
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
}
