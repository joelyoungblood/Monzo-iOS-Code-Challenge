//
//  ArticleBodyTableViewCell.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class ArticleBodyTableViewCell: UITableViewCell, ReusableView {
    
    private struct Constants {
        static let offset: CGFloat = 30.0
        static let fontSize: CGFloat = 21.0
    }
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .baskerville(ofSize: Constants.fontSize)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        contentView.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.offset)
            make.leading.equalToSuperview().offset(Constants.offset)
            make.trailing.equalToSuperview().inset(Constants.offset)
            make.bottom.equalToSuperview().inset(Constants.offset)
        }
    }
    
    func setup(for article: Article) {
        bodyLabel.text = article.body
    }
}
