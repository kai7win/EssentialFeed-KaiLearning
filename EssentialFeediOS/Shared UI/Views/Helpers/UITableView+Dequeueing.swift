//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/19.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
