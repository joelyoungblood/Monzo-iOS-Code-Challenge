//
//  ArticleViewModel.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class ArticleViewModel {
    
    private let disposeBag = DisposeBag()
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let articles = PublishSubject<[ArticleDetailViewController]>()
    let error = PublishSubject<HeadlinesError>()
    
    func fetchData() {
        isLoading.onNext(true)
        Request.allArticles().subscribeOn(SerialDispatchQueueScheduler(qos: .userInitiated))
            .do(onNext: { [weak self] allArticles in
                self?.isLoading.onNext(false)
                self?.articles.onNext(allArticles.map { ArticleDetailViewController(with: $0) })
            }, onError: { [weak self] error in
                self?.error.onNext(error as! HeadlinesError)
            }).bind(to: Realm.rx.add(update: true))
            .disposed(by: disposeBag)
    }
}
