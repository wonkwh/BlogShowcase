//
//  ListController.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/15.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import LBTATools
import Nuke
import SkeletonView

class ListCell: UICollectionViewCell {
    let imageView = AspectFitImageView(image: nil, cornerRadius: 16)
    let nameLabel: UILabel = {
        let view = UILabel(text: "TrackName", font: .boldSystemFont(ofSize: 18))
        view.isSkeletonable = true
        return view
    }()

    let subtitleLabel = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)

        [imageView, nameLabel, subtitleLabel].forEach { view in
            view.isSkeletonable = true
        }

        hstack(
            imageView.withSize(.init(width: 80, height: 80)),
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


class ListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "cellId"
    fileprivate let footerId = "footerId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.shouldAnimate = false

            self.collectionView.reloadData()
        }

        collectionView.register(ListCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        fetchData()
    }

    var results = [Result]()

    fileprivate let searchTerm = "BTS"

    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
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

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    var isPaginating = false
    var isDonePaginating = false
    var shouldAnimate = true

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListCell

        if shouldAnimate {
            cell.showAnimatedGradientSkeleton()
        } else {
            let track = results[indexPath.item]
            cell.configure(viewData: track)
            cell.hideSkeleton()
        }

        // initiate pagination
        if indexPath.item == results.count - 1 && !isPaginating {
            print("fetch more data")

            isPaginating = true

            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in

                if let err = err {
                    print("Failed to paginate data:", err)
                    return
                }

                if searchResult?.results.count == 0 {
                    self.isDonePaginating = true
                }

                sleep(2)

                self.results += searchResult?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPaginating = false
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }

}

extension ListController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellId
    }
}
