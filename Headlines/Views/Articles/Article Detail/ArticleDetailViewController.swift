//
//  ArticleDetailViewController.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxRealm
import RealmSwift

final class ArticleDetailViewController: UIViewController, Alertable {
    
    private var article: Article
    private let currentArticleId: String
    
    private enum ArticleDetailSections: Int, EnumIterable {
        case title
        case body
        case favorite
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ArticleTitleTableViewCell.self)
        tableView.register(ArticleBodyTableViewCell.self)
        tableView.register(FavouriteTableViewCell.self)
        return tableView
    }()
    
    init(with article: Article) {
        self.article = article
        self.currentArticleId = article.id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    fileprivate func addToRealm() {
        let realm = try! Realm()
        try! realm.write { [weak self] in
            guard let this = self else { return }
            this.article.isFavourited = !this.article.isFavourited
            let favoritesIndexPath = IndexPath(item: ArticleDetailSections.favorite.rawValue, section: 0)
            this.tableView.reloadRows(at: [favoritesIndexPath], with: .none)
            realm.safeAdd(article)
        }
    }
}

extension ArticleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleDetailSections.count
    }
}

extension ArticleDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ArticleDetailSections(rawValue: indexPath.row)!
        
        switch section {
        case .title:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ArticleTitleTableViewCell
            cell.setup(for: article)
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ArticleBodyTableViewCell
            cell.setup(for: article)
            return cell
        case .favorite:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FavouriteTableViewCell
            cell.set(article.isFavourited)
            cell.addToFavoritesButton.rx
                .tap.subscribeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    self?.addToRealm()
                }).disposed(by: cell.disposeBag)
            
            cell.goToFavoritesButton.rx
                .tap.subscribeOn(MainScheduler.instance)
                .subscribe(onNext: { _ in
                    NotificationCenter.default.post(AppConstants.favouritesNavNotification)
                }).disposed(by: cell.disposeBag)
            return cell
        }
    }
}
