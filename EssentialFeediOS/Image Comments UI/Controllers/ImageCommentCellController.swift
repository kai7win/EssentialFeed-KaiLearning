//
//  ImageCommentCellController.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/5/16.
//

import UIKit
import EssentialFeed_KaiLearning

public class ImageCommentCellController: CellController {
    
    private let model: ImageCommentViewModel

    public init(model: ImageCommentViewModel) {
        self.model = model
    }

    public func view(in tableView: UITableView) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = model.message
        cell.usernameLabel.text = model.username
        cell.dateLabel.text = model.date
        return cell
    }

}
