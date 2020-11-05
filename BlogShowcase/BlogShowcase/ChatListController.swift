//
//  ChatListController.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/11/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import ChatLayout

class ChatListController: UIViewController {

    var chatLayout: ChatLayout = {
        let layout = ChatLayout()
        layout.settings.interItemSpacing = 8
        layout.settings.interSectionSpacing = 8
        layout.settings.additionalInsets = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        layout.keepContentOffsetAtBottomOnBatchUpdates = true
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: chatLayout)
        view.alwaysBounceVertical = true
        view.keyboardDismissMode = .interactive
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false

        view.isPrefetchingEnabled = false
        view.contentInsetAdjustmentBehavior = .always
        if #available(iOS 13.0, *) {
            view.automaticallyAdjustsScrollIndicatorInsets = true
        }

        return view
    }()

    var results = [Result]()

    fileprivate func fetchSamleData() {
        let urlString = "https://itunes.apple.com/search?term=IU&offset=0&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
            if let err = err {
                print("Failed to paginate data:", err)
                return
            }

            self.results = searchResult?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ListCell.self, forCellWithReuseIdentifier: "ChatCellId")
        collectionView.register(LoadingFooter.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerId")

        collectionView.dataSource = self
        collectionView.delegate = self
        chatLayout.delegate = self

        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeAreaLayoutGuide()
        self.fetchSamleData()
        FPSCounter.showInStatusBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        FPSCounter.hide()
    }
}

extension ChatListController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCellId", for: indexPath) as! ListCell

        let track = results[indexPath.item]
        cell.configure(viewData: track)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        return header
    }
}


// MARK: - ChatLayoutDelegate
extension ChatListController: ChatLayoutDelegate {
    func shouldPresentHeader(_ chatLayout: ChatLayout, at sectionIndex: Int) -> Bool {
        return true
    }

    func sizeForItem(_ chatLayout: ChatLayout, of kind: ItemKind, at indexPath: IndexPath) -> ItemSize {
        switch kind {
        case .cell:
            return .estimated(CGSize(width: chatLayout.layoutFrame.width, height: 40))
        case .header:
            return .auto
        default:
            return .auto
        }
    }

    func alignmentForItem(_ chatLayout: ChatLayout, of kind: ItemKind, at indexPath: IndexPath) -> ChatItemAlignment {
        switch kind {
        case .cell:
            return .leading
        default:
            return .center
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ChatListController: UICollectionViewDelegate {

}
