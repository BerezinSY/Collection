# Collection

A description of this package.

1. Make import the library (import Collection) in your file
2. Create a model struct and subscribe the model to CollectionModel protocol
3. Create subclass of CollectionViewCell and place there Item type of the model
4. Create subclass of CollectionReusableView and place there Header type of the model
5. Create subclass of CollectionViewController and:
    a. Place in type placeholder Model type
    b. Place in type placeholder Header type
    c. Place in type placeholder Cell type
 

Example:

//-//-//-//-//-//-//-//-//-//-Create a model...-//-//-//-//-//-//-//-//-//-//-
struct Model: CollectionModel {
    var header: String
    var items: [String]
    var isShowHeader: Bool
}


//-//-//-//-//-//-Create subclass of CollectionViewCell...-//-//-//-//-//-//-
class Cell: CollectionViewCell<String> {

    @IBOutlet private var label: UILabel?
    
    override var item: String? {
        didSet {
            label?.text = item
        }
    }
}


//-//-//-//-//-Create subclass of CollectionReusableView...-//-//-//-//-//-//-
class Header: CollectionReusableView<String> {}


//-//-//-//-//-Create subclass of CollectionViewController...-//-//-//-//-//-
class Controller: CollectionViewController<Model, Header, Cell> {}


//-//-//-//-//-//-//-//-//-//-Launch table-//-//-//-//-//-//-//-//-//-//-//-//-
In SceneDelegate file make code:

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    let vc = Controller()
    vc.content = [
    Model(header: "Header 1", items: ["1", "2", "3", "4", "5", ], isShowHeader: true),
    Model(header: "Header 2", items: ["1", "2", "3", "4", "5", ], isShowHeader: false),
    Model(header: "Header 3", items: ["1", "2", "3", "4", "5", ], isShowHeader: true),
    ]
    window.rootViewController = vc
    window.makeKeyAndVisible()
    self.window = window
}
