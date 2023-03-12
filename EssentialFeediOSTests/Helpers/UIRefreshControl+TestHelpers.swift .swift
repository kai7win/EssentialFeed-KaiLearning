//
//  UIRefreshControl+TestHelpers.swift .swift
//  EssentialFeediOSTests
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import UIKit

extension UIRefreshControl{
    func simulatePullToRefresh(){
        simulate(event: .valueChanged)
    }
}
