import UIKit
import SnapKit
import AlamofireImage

class MainViewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "MainViewTableViewCell"

    //MARK: - Views
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    //MARK: - Private Properties
    private var starButtonIsActive = false
    private var imageURL = ""
    
    //MARK: - Life Circle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(subviews: characterImageView, characterNameLabel)
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
            $0.left.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(characterImageView)
            $0.left.equalTo(characterImageView).offset(8)
        }
    
    }
    
    //MARK: - Public Methods
    func configure(with result: Result?) {
        characterNameLabel.text = result?.name
//        DispatchQueue.global().async {
            guard let stringUrl = result?.image else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
//            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//            DispatchQueue.main.async {
//                self.characterImageView.image = UIImage(data: imageData)
//            }
//        }
        characterImageView.af.setImage(withURL: imageUrl)
        
    }
}
