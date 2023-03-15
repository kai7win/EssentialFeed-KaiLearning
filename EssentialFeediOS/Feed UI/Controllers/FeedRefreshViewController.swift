//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import UIKit

protocol FeedRefreshViewControllerDelegate{
    func didRequestFeedRefresh()
}


final class FeedRefreshViewController: NSObject,FeedLoadingView {
    
    @IBOutlet private var view: UIRefreshControl?
    
    var delegate:FeedRefreshViewControllerDelegate?
    
    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel:FeedLoadingViewModel) {
        if viewModel.isLoading{
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    

    
}
