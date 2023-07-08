public protocol CollectionModel {
    associatedtype Item
    associatedtype Header
    
    var items: [Item] { get }
    var header: Header { get }
    var isShowHeader: Bool { get }
}
