//
//  ListCell.swift
//  BlogShowcase
//
//  Created by kwanghyun.won on 2020/11/09.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import LBTATools
import Nuke

class ListCell: UICollectionViewCell {
    let imageView = AspectFitImageView(image: nil, cornerRadius: 16)
    let nameLabel = UILabel(text: "TrackName", font: .boldSystemFont(ofSize: 18))
    let subtitleLabel = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)

        hstack(
            imageView.withWidth(80),
            stack(nameLabel, subtitleLabel, spacing: 4),
            spacing: 16
        ).withMargins(.allSides(16))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension ListCell {
    func configure(viewData: ResultViewData) {
        self.nameLabel.text = viewData.title
        self.subtitleLabel.text = viewData.subtitle
        if let url = viewData.albumCoverURL {
            Nuke.loadImage(with: url, into: self.imageView)
        }
    }
}
