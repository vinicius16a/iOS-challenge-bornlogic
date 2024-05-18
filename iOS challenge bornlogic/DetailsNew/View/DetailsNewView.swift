import Foundation
import UIKit

protocol DetailsNewViewProtocol {
    var presenter: DetailsNewPresenterProtocol? { get set }
    func showArticleDetail(_ article: Article)
}

class DetailsNewView: UIViewController, DetailsNewViewProtocol {
    var presenter: DetailsNewPresenterProtocol?
    var article: Article?

    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()

    let publicationDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 24)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
        setupViews()
        configViews()
    }
    

    private func setupViews() {
        view.addSubview(articleImageView)
        view.addSubview(publicationDateLabel)
        view.addSubview(contentTextView)

        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            articleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleImageView.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),

            publicationDateLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
            publicationDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            publicationDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            contentTextView.topAnchor.constraint(equalTo: publicationDateLabel.bottomAnchor, constant: 10),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    private func configViews() {
        if let url = URL(string: article?.urlToImage ?? "") {
            URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                guard let data = data, error == nil else{return}

                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.articleImageView.image = image!
                }

            }).resume()
        }

        let date = DateFormatter.formatDdMmAa.string(from: article?.publishedAt ?? Date())
        publicationDateLabel.text = "Publication Date: \(date)"

        contentTextView.text = article?.content
    }

    func showArticleDetail(_ article: Article) {
        self.article = article
    }
    

}
