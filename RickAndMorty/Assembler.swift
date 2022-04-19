import UIKit

protocol ModuleAssemblerProtocol {
    static func createDetailModule(result: Result) -> UIViewController
}

class ModuleAssembler: ModuleAssemblerProtocol {
    
    static func createDetailModule(result: Result) -> UIViewController {
        let view = DetailViewController()
        let networkManger = NetworkManager()
        let presenter = DetailViewPresenter(view: view, networkManager: networkManger, result: result)
        view.presenter = presenter
        return view
    }

}
