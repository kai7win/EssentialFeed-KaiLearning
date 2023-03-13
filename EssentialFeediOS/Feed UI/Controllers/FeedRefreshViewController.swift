//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import UIKit

final class FeedRefreshViewController: NSObject,FeedLoadingView {
    
    private(set) lazy var view = loadView()
    private let presentr: FeedPresenter
    
    init(presentr: FeedPresenter) {
        self.presentr = presentr
    }
    
    @objc func refresh() {
        presentr.loadFeed()
    }
    
    func display(isLoading: Bool) {
        if isLoading{
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
}
