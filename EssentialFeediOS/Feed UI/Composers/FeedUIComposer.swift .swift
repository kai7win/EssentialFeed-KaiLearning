//
//  FeedUIComposer.swift .swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import UIKit
import EssentialFeed_KaiLearning

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presentr: presenter)
        let feedController = FeedViewController(refreshController: refreshController)
        
        presenter.loadingView = refreshController
        presenter.feedView = FeedViewAdapter(controller: feedController, imageLoader: imageLoader)
        
        return feedController
        
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { model in
                FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader,imageTransformer: UIImage.init))
            }
        }
    }
    
}


private final class FeedViewAdapter:FeedView{
    
    private weak var controller:FeedViewController?
    private let imageLoader:FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(feed: [EssentialFeed_KaiLearning.FeedImage]) {
        controller?.tableModel = feed.map { model in
            FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: imageLoader,imageTransformer: UIImage.init))
        }
    }
    
}
