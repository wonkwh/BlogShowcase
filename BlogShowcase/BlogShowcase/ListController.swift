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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListCell

        let track = results[indexPath.item]

        cell.nameLabel.text = track.trackName
        if let url = URL(string: track.artworkUrl100) {
            Nuke.loadImage(with: url, into: cell.imageView)
        }

        //cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
        cell.subtitleLabel.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"

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

