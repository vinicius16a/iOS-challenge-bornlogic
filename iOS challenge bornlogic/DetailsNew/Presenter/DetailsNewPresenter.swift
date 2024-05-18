import Foundation

protocol DetailsNewPresenterProtocol {
    var view: DetailsNewViewProtocol? { get set }
    var article: Article? { get set }

    func viewDidLoad()
}

class DetailsNewPresenter: DetailsNewPresenterProtocol {
    var view: DetailsNewViewProtocol?
    var article: Article?
    
    func viewDidLoad() {
        if let article = article {
            view?.showArticleDetail(article)
        }
    }
}
