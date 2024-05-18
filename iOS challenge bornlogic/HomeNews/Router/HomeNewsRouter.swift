//
//  HomeNewsRouter.swift
//  iOS challenge bornlogic
//
//  Created by Vinicius Bruno on 12/05/24.
//

import Foundation
import UIKit

typealias EntryPoint = HomeNewsViewProtocol & UIViewController

protocol HomeNewsRouterProtocol {
    var entry: EntryPoint? { get }
    static func start() -> HomeNewsRouterProtocol
    func presentArticleDetail(for article: Article)
}

class HomeNewsRouter: HomeNewsRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> any HomeNewsRouterProtocol {
        let router = HomeNewsRouter()
        var view: HomeNewsViewProtocol = HomeNewsViewController()
        var presenter: HomeNewsPresenterProtocol = HomeNewsPresenter()
        var interactor: HomeNewsInteractorProtocol = HomeNewsInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint

        return router
    }

    func presentArticleDetail(for article: Article) {
        let articleDetailVIew = DetailsNewRouter.createeModule(with: article)
//        entry?.navigationController?.pushViewController(articleDetailVIew, animated: true)
        entry?.present(articleDetailVIew, animated: true)
    }

}
