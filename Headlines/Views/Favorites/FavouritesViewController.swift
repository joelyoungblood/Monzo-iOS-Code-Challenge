//
//  FavouritesViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm
import RxRealmDataSources
import NSObject_Rx

final class FavouritesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = doneBarButton
        view.backgroundColor = .white
        
        doneBarButton.rx.tap
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: rx.disposeBag)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        bindToRealm()
    }
    
    //Normally I'd like to handle this in a view model, but I ran out of time ;)
    private func bindToRealm() {
        let realm = try! Realm()
        
        let dataSource = RxTableViewRealmDataSource<Article>(cellIdentifier: String(describing: UITableViewCell.self),
                                                             cellType: UITableViewCell.self) { cell, indexPath, article in
            
            cell.textLabel?.text = article.title
        }
        
        let predicate = NSPredicate(format: "isFavourited = true")
        
        Observable.changeset(from: realm.objects(Article.self).filter(predicate))
            .bind(to: tableView.rx.realmChanges(dataSource))
            .disposed(by: rx.disposeBag)
        
        tableView.rx.realmModelSelected(Article.self)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { article in
                //TODO: handle article tap
            }).disposed(by: rx.disposeBag)
    }
}
