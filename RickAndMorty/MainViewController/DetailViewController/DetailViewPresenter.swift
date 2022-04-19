import Foundation

protocol DetailViewPresenterProtocol {
    init(view: DetailViewControllerProtocol, networkManager: NetworkManagerProtocol,result: Result)
    var result: Result { get }
    func fetchCharacter()
}

final class DetailViewPresenter: DetailViewPresenterProtocol {

    var result: Result
    
    unowned let view: DetailViewControllerProtocol
    
    private let networkManager: NetworkManagerProtocol!
    
    required init(view: DetailViewControllerProtocol, networkManager: NetworkManagerProtocol, result: Result) {
        self.view = view
        self.networkManager = networkManager
        self.result = result
    }
    
    func fetchCharacter() {
        networkManager.fetchCharacter(from: result.url ) { [weak self] result in
            guard let self = self else { return }
            self.result = result
            self.view.setCharacterImage(with: result.image)
            self.view.setupUI(result: result)
        }
    }
}
