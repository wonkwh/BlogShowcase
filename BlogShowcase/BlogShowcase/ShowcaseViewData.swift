//
//  ShowcaseViewData.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/15.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import SwiftUI
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

class ShowcaseSwiftUIDynamicList: Showcase {
    func makeViewController() -> UIViewController {
        let view = DynamicsListView()
        let vc = UIHostingController(rootView: view)
        return vc
    }
}

class ShowcaseSwiftUIFacebookLayout: Showcase {
    func makeViewController() -> UIViewController {
        let view = FacebookLayoutView()
        let vc = UIHostingController(rootView: view)
        return vc
    }
}

class ShowcaseSwiftUICustomViewModifiers: Showcase {
    func makeViewController() -> UIViewController {
        let view = ModifierStackView()
        let vc = UIHostingController(rootView: view)
        return vc
    }
}
