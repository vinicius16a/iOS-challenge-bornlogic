import Foundation
import UIKit

protocol HomeNewsViewProtocol {
    var presenter: HomeNewsPresenterProtocol? { get set }

    func update(with news: [Article])
    func update(with error: String)
}

class HomeNewsViewController: UIViewController, HomeNewsViewProtocol {
    var presenter: HomeNewsPresenterProtocol?
    private var news: [Article] = []

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        table.isHidden = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func update(with news: [Article]) {
        DispatchQueue.main.async {
            self.news = news
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    func update(with error: String) {
        print(error)
    }

    private func setupViews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeNewsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = news[indexPath.row].title
        cell.descriptionLabel.text = news[indexPath.row].description
        cell.authorLabel.text = news[indexPath.row].author ?? ""
        cell.articleImageView.image = nil
        if let url = URL(string: news[indexPath.row].urlToImage ?? "") {
            URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                guard let data = data, error == nil else{return}

                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    cell.update(image: image)
                }

            }).resume()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectArticle(news[indexPath.row])
    }
}
