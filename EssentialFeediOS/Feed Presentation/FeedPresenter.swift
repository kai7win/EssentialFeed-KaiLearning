//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/13.
//

import Foundation
import EssentialFeed_KaiLearning


protocol FeedLoadingView{
    func display(_ viewModel:FeedLoadingViewModel)
}


protocol FeedView{
    func display(_ viewModel:FeedViewModel)
}

final class FeedPresenter{
    
    private let feedView:FeedView
    private let loadingView:FeedLoadingView
    
    init(feedView: FeedView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.loadingView = loadingView
    }
    
    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedPresenter.self),
                                 comment: "Title for the feed view")
    }
    
    
    func didStarLoadingFeed(){
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed:[FeedImage]){
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error:Error){
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
