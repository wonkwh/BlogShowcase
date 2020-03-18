//
//  ShowcaseViewData.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/15.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import ShowcaseKit

class ShowcaseViewData: Showcase {
    func makeViewController() -> UIViewController {
        return ListController(collectionViewLayout: UICollectionViewFlowLayout())
    }
}

class ShowcaseMicroList: Showcase {
    func makeViewController() -> UIViewController {
        return MicroListController()
    }
}

class ShowcaseForumList: Showcase {
    func makeViewController() -> UIViewController {
        return ForumPostListController()
    }
}
