import UIKit
import SnapKit
import AlamofireImage

class MainViewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "MainViewTableViewCell"

    //MARK: - Views
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2823102176, green: 0.1690107286, blue: 0.146335572, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: - Private Properties
    private var starButtonIsActive = false
    private var imageURL = ""
    
    //MARK: - Life Circle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(subviews: characterImageView, characterNameLabel, activityIndicator)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(12)
            $0.height.equalTo(80)
            $0.width.equalTo(80)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalTo(characterImageView.snp.centerX)
            $0.centerY.equalTo(characterImageView.snp.centerY)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(characterImageView)
            $0.left.equalTo(characterImageView.snp.right).offset(16)
        }
    }
    
    //MARK: - Public Methods
    func configure(with result: Result?) {
        characterNameLabel.text = result?.name
        guard let stringUrl = result?.image else { return }
        guard let imageUrl = URL(string: stringUrl) else { return }
        characterImageView.af.setImage(withURL: imageUrl)
        activityIndicator.stopAnimating()
    }
}
