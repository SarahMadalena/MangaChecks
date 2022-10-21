//
//  MangaTableViewCell.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//

import UIKit

class MangaTableViewCell: UITableViewCell {
    
    //feito dessa forma por ser opcionl
    //    var manga: MangasData? {
    //        didSet {
    //            configure(data: manga)
    //        }
    //    }
    
    weak var cellDelegate: CellDelegate?
    
    let profileImagesView: UIImageView! = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    
    var manga: MangasData?
    
    let title:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //usar isso para a tag dos mangás
    let genresDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  .systemGray6
        label.backgroundColor =  .systemCyan
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button:UIButton = {
        let button = UIButton(type: .system)
        button.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Add+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.tappedButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImagesView)
        containerView.addSubview(title)
        containerView.addSubview(genresDetailedLabel)
        self.containerView.addSubview(button)
        self.contentView.addSubview(containerView)
        
        profileImagesView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true;
        profileImagesView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true;
        profileImagesView.widthAnchor.constraint(equalToConstant:80).isActive = true;
        profileImagesView.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true;
        containerView.leadingAnchor.constraint(equalTo:self.profileImagesView.trailingAnchor, constant:10).isActive = true;
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true;
        containerView.heightAnchor.constraint(equalToConstant:80).isActive = true
        
        title.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true;
        title.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true;
        title.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        genresDetailedLabel.topAnchor.constraint(equalTo:self.title.bottomAnchor).isActive = true;
        genresDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true;
        genresDetailedLabel.topAnchor.constraint(equalTo:self.title.bottomAnchor).isActive = true
        
        button.widthAnchor.constraint(equalToConstant:40).isActive = true
        button.heightAnchor.constraint(equalToConstant:40).isActive = true
        button.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
        button.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func tappedButton(sender:UIButton){
        cellDelegate?.addManga(with: manga!)
    }
    
    func configure(with manga: MangasData) {
        self.manga = manga
        if let imageURL = manga.images.jpg?.image_url {
            profileImagesView.sd_setImage(with: URL(string: imageURL))
            
        }
        //profileImagesView.image = UIImage(named: manga.images.url)
        title.text = manga.title
        let genres = [Genre(name: "drama"), Genre(name: "mystery")]
        let genresName = genres.map({ $0.name })
        let genresJoin = genresName.joined(separator: ", ")
        //map(): transformando arrays em string
        genresDetailedLabel.text = " \(genresJoin) "
    }
    
}


protocol CellDelegate: AnyObject {
    func addManga(with manga: MangasData)
}
