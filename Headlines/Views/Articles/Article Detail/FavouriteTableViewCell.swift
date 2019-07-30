//
//  FavoriteTableViewCell.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import RxSwift

//I drop the scheme of 'ArticleSectionTableViewCell' here on the assumption this cell may get reused hither and there in a full app
final class FavouriteTableViewCell: UITableViewCell, ReusableView {
    
    private(set) var disposeBag = DisposeBag()
    
    private struct Constants {
        static let buttonWidth: CGFloat = 26
        static let buttonHeight: CGFloat = 25
        static let horizontalOffset: CGFloat = 30
        static let bottomOffset: CGFloat = 35
        static let fontSize: CGFloat = 17
    }
    
    let addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "favourite-on"), for: .selected)
        button.setBackgroundImage(UIImage(named: "favourite-off"), for: .normal)
        return button
    }()
    
    let goToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favourites", for: [])
        button.titleLabel?.font = .sfUISemibold(ofSize: Constants.fontSize)
        button.setTitleColor(.headlinesGold, for: [])
        return button
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
        
        contentView.addSubview(addToFavoritesButton)
        addToFavoritesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.bottomOffset)
            make.leading.equalToSuperview().offset(Constants.horizontalOffset)
            make.bottom.equalToSuperview().inset(Constants.bottomOffset)
            make.width.equalTo(Constants.buttonWidth)
            make.height.equalTo(Constants.buttonHeight)
        }
        
        contentView.addSubview(goToFavoritesButton)
        goToFavoritesButton.snp.makeConstraints { make in
            make.centerY.equalTo(addToFavoritesButton.snp.centerY)
            make.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            make.bottom.equalToSuperview().inset(Constants.bottomOffset)
        }
    }
    
    func set(_ isFavorited: Bool) {
        addToFavoritesButton.isSelected = isFavorited
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
