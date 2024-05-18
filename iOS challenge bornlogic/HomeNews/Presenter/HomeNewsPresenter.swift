import Foundation

protocol HomeNewsPresenterProtocol {
    var router: HomeNewsRouterProtocol? { get set }
    var interactor: HomeNewsInteractorProtocol? { get set }
    var view: HomeNewsViewProtocol? { get set }

    func interactorDidFetchNews(with result: Result<[Article], Error>)
    func didSelectArticle(_ article: Article)
}

class HomeNewsPresenter: HomeNewsPresenterProtocol {
    var router: (any HomeNewsRouterProtocol)?
    var interactor: (any HomeNewsInteractorProtocol)? {
        didSet {
            interactor?.getNews()
        }
    }
    var view: (any HomeNewsViewProtocol)?

    func interactorDidFetchNews(with result: Result<[Article], any Error>) {
        switch result {
        case .success(let articles):
            view?.update(with: articles)
        case .failure:
            view?.update(with: "Something wrong with request")
        }
    }

    func didSelectArticle(_ article: Article) {
        router?.presentArticleDetail(for: article)
    }
}
