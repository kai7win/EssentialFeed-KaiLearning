//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
