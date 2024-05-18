import Foundation

//https://newsapi.org/v2/everything?q=keyword&apiKey=1f9b0b2bb5864c02b809575a20ba015d

protocol HomeNewsInteractorProtocol {
    var presenter: HomeNewsPresenterProtocol? { get set }

    func getNews()
}

class HomeNewsInteractor: HomeNewsInteractorProtocol {
    var presenter: (any HomeNewsPresenterProtocol)?
    
    func getNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=keyword&apiKey=1f9b0b2bb5864c02b809575a20ba015d") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchNews(with: .failure(FetchError.failed))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let entities = try decoder.decode(NewsAPIResponse.self, from: data)
                self?.presenter?.interactorDidFetchNews(with: .success(entities.articles ?? []))
            } catch {
                print(error.localizedDescription)
                self?.presenter?.interactorDidFetchNews(with: .failure(FetchError.failed))
            }
        }
        task.resume()
    }
}
