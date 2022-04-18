import Foundation

    //MARK: - MainViewPresenterProtocol

protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol, networkManager: NetworkManagerProtocol)
    var rickAndMorty: RickAndMorty? { get }
    func fetchData()
}

final class MainViewPresenter: MainViewPresenterProtocol {
 
    unowned let  view: MainViewProtocol
    let networkManager: NetworkManagerProtocol!
    
    var rickAndMorty: RickAndMorty?
    
    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func fetchData() {
        networkManager.fetchData(from: "https://rickandmortyapi.com/api/character") { [weak self] rickAndMorty in
            guard let self = self else { return }
            self.rickAndMorty = rickAndMorty
            self.view.reloadData()
        }
    }
    
}
