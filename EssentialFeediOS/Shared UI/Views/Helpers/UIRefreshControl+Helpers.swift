//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/4/8.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
