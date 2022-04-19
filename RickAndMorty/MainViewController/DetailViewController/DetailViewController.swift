import UIKit
import SnapKit

protocol DetailViewControllerProtocol: AnyObject {
    func setupUI(result: Result)
    func setCharacterImage(with url:String)
}

final class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    private let closeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9709939361, green: 0.9568827748, blue: 0.9220435023, alpha: 1)
        setupCloseButton()
        setupSubviews(subviews: characterImageView, characterDescription, activityIndicator)
        presenter.fetchCharacter()
        setupConstraints()
    }
    
    // MARK: - Private Property

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var characterDescription: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2823102176, green: 0.1690107286, blue: 0.146335572, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Private Methods

    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = #colorLiteral(red: 0.2823102176, green: 0.1690107286, blue: 0.146335572, alpha: 1)
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        // Constraints
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.right.equalToSuperview().inset(20)
        }
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.height.equalTo(200)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        characterDescription.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(characterImageView.snp.bottom).offset(60)
        }
    }
}

extension DetailViewController: DetailViewControllerProtocol {
   
    func setCharacterImage(with url: String) {
        guard let imageUrl = URL(string: url) else { return }
        characterImageView.af.setImage(withURL: imageUrl)
        activityIndicator.stopAnimating()
    }
    
    func setupUI(result: Result) {
        print(result.description)
        characterDescription.text = result.description
    }
}
