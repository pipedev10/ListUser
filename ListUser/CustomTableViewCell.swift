//
//  CustomTableViewCell.swift
//  ListUser
//
//  Created by Pipe Carrasco on 22-05-21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .orange
        contentView.addSubview(myLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String){
        myLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        myLabel.frame = CGRect(x: 10,
                               y: 0,
                               width: contentView.frame.size.width - 10,
                               height: contentView.frame.size.height)
    }
}
