//
//  TableViewCell.swift
//  PoketProject
//
//  Created by arthur on 7/18/24.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"

    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.borderWidth = 2
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.gray.cgColor
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        [
            image,
            nameLabel,
            phoneLabel
        ].forEach { contentView.addSubview($0) }
        
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        phoneLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
 
    }
    
    public func configureCell(phoneBookList: PhoneBook) {
        nameLabel.text = "name"
        phoneLabel.text = "phone"
    }
}
