//
//  ArticleTitleTableViewCell.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

final class ArticleTitleTableViewCell: UITableViewCell, ReusableView {
    
    private struct Constants {
        static let imageHeight: CGFloat = 350.0
        static let bottomOffset: CGFloat = 21.0
        static let horizontalOffset: CGFloat = 30.0
    }
    
    private let headlineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .superclarendonBold(ofSize: 32.0)
        label.textColor = .headlinesLightGrey
        label.numberOfLines = 0
        return label
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let topColor = UIColor.black.withAlphaComponent(0.0)
        let bottomColor = UIColor.black.withAlphaComponent(1.0)
        return CAGradientLayer.verticalGradient(withColors: [bottomColor, topColor], andLocations: [0.0, 1.0])
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
        
        contentView.addSubview(headlineImageView)
        headlineImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Constants.imageHeight)
        }
        
        headlineImageView.layer.addSublayer(gradientLayer)
        
        headlineImageView.addSubview(headlineLabel)
        headlineLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.bottomOffset)
            make.leading.equalToSuperview().offset(Constants.horizontalOffset)
            make.trailing.equalToSuperview().inset(Constants.horizontalOffset)
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        gradientLayer.frame = headlineImageView.frame
    }
    
    func setup(for article: Article) {
        if let url = article.imageURL {
            headlineImageView.sd_setImage(with: url, completed: nil)
        }
        
        headlineLabel.text = article.title
    }
}
