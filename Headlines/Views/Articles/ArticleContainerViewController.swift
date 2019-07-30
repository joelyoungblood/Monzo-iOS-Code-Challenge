//
//  ViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD
import RxSwift
import RxCocoa
import NSObject_Rx

final class ArticleContainerViewController: UIPageViewController, Alertable {
    
    private let viewModel = ArticleViewModel()
    private var articleViewControllers: [ArticleDetailViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        view.backgroundColor = .white
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.fetchData()
        
        viewModel.articles.subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewControllers in
                self?.articleViewControllers = viewControllers
                if let firstViewController = viewControllers.first {
                    self?.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                }
            }).disposed(by: rx.disposeBag)
        
        viewModel.isLoading.subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let this = self else { return }
                if isLoading {
                    MBProgressHUD.showAdded(to: this.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: this.view, animated: true)
                }
            }).disposed(by: rx.disposeBag)
        
        viewModel.error.subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(for: error)
            }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(AppConstants.favouritesNavNotification.name)
            .subscribeOn(MainScheduler.instance).subscribe(onNext: { [weak self] _ in
                let favoritesNavControler = UINavigationController(rootViewController: FavouritesViewController())
                self?.present(favoritesNavControler, animated: true, completion: nil)
            }).disposed(by: rx.disposeBag)
    }
}

extension ArticleContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let articles = articleViewControllers else { return nil }
        
        guard let currentArticleVc = viewController as? ArticleDetailViewController,
            let viewControllerIndex = articleViewControllers?.firstIndex(of: currentArticleVc) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return articles.last }
        guard articles.count > previousIndex else { return nil }
        return articles[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let articles = articleViewControllers else { return nil }

        guard let currentArticleVc = viewController as? ArticleDetailViewController,
            let viewControllerIndex = articles.firstIndex(of: currentArticleVc) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < articles.count else { return articles.first }
        guard articles.count > nextIndex else { return nil }
        return articles[nextIndex]
    }
}
