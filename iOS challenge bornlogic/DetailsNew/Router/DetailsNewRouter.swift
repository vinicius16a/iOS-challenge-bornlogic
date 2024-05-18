import Foundation
import UIKit

protocol DetailsNewRouterProtocol {
    static func createeModule(with article: Article) -> UIViewController
}

class DetailsNewRouter: DetailsNewRouterProtocol {
    static func createeModule(with article: Article) -> UIViewController {
        let view = DetailsNewView()
        var presenter: DetailsNewPresenterProtocol = DetailsNewPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.article = article

        return view
    }
}
