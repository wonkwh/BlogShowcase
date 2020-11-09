//
//  LoadingFooter.swift
//  BlogShowcase
//
//  Created by kwanghyun on 2020/11/09.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class LoadingFooter: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()

        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center

        stack(aiv, label, spacing: 8).withSize(.init(width: 200, height: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
