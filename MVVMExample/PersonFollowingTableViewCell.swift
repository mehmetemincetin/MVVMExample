//
//  PersonFollowingTableViewCell.swift
//  MVVMExample
//
//  Created by Mehmet Emin Çetin on 15.07.2025.
//  static anahtar kelimesi ile sınıf seviyesinde tanımlanır yani örneği oluşturmaya gerek yoktur
//  PersonFollowingTableViewCell.identifier diyerek direk çağırılabilir.
//  Bellekte yalnızca bir kez yer kaplar
//  Genellikle sabit değerler, ortak ayarlar, paylaşılan durumlar gibi şeyler için kullanılır
//  static let ve var Override edilemez


import UIKit


/// AnyObject kullanmak sadece sınıf türlerine conform etmek anlamına gelir. Ayrıca Weak referansını da kullanmamıza izin verir.
protocol PersonFollowingTableViewCellDelegate: AnyObject {
    
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingTableViewCell: UITableViewCell {

    static let identifier = "PersonFollowingTableViewCell"
    
    weak var delegate: PersonFollowingTableViewCellDelegate?
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
      
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userImageView)
        contentView.addSubview(button)
        contentView.clipsToBounds = true
        
        // "#" ifadesi derleme zamanına özel ifade anlamına gelir, derleyici bunun önündeki ifadeye derleme anında kontroller yapar, var mı yok mu doğru yazılmış mı objc kullanılmış mı diye.
        button.addTarget(self, action: #selector(didTapButton), for:  .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    // objc ifadesi Swiftte kodunun Objective-C sistemlerine, API'lerine ve runtime mekanizmalarına erişmesini mümkün kılar.
    @objc private func didTapButton() {
        guard let viewModel = viewModel else {
            return
        }
        
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        
        delegate?.personFollowingTableViewCell(self, didTapWith: viewModel)
        
        prepareForReuse()
        configure(with: newViewModel)
    }
    
    
    
    func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
        userImageView.image = viewModel.image
        
        if viewModel.currentlyFollowing {
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 8
            
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 10
            button.layer.shadowOpacity = 0.3
            button.layer.masksToBounds = false
        } else {
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .link
            button.layer.cornerRadius = 8
            
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 10
            button.layer.shadowOpacity = 0.3
            button.layer.masksToBounds = false
            
            

        }
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWidth = contentView.frame.size.height-10
        userImageView.frame = CGRect(x: 5, y: 5,
                                     width: imageWidth,
                                     height: imageWidth)
        
        nameLabel.frame = CGRect(x: imageWidth+10, y: 0,
                                 width: contentView.frame.size.width-imageWidth,
                                 height: contentView.frame.size.height/2)
        
        usernameLabel.frame = CGRect(x: imageWidth+10,
                                     y: contentView.frame.size.height/2,
                                     width: contentView.frame.size.width-imageWidth,
                                     height: contentView.frame.size.height/2)
    
        button.frame = CGRect(x: contentView.frame.size.width-120,
                              y: 10,
                              width: 110,
                              height: contentView.frame.size.height-20)
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        usernameLabel.text = nil
        userImageView.image = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
    }
}

