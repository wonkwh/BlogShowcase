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

class ShowcaseTiktokClone: Showcase {
    func makeViewController() -> UIViewController {
        return TikTokController()
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

class ShowcaseSwiftUIViewModifiers2: Showcase {
    func makeViewController() -> UIViewController {
        let view = ModifierStackView()
        let vc = UIHostingController(rootView: view)
        return vc
    }
}

class ShowcaseButtonAnimationView: Showcase {
    func makeViewController() -> UIViewController {
//      if #available(iOS 14.0, *) {
        let view = ButtonAnimationView()
        let vc = UIHostingController(rootView: view)
        return vc
//      }
    }
}

