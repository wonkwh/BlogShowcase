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

class ShowcaseEnumDrivenList: Showcase {
    func makeViewController() -> UIViewController {
        return EnumListController(collectionViewLayout: UICollectionViewFlowLayout())
    }
}

class ShowcaseChatLayout: Showcase {
    func makeViewController() -> UIViewController {
        return ChatListController()
    }
}






