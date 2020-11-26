//
//  EnumListController.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/11/09.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

enum DataState {
    case loading
    case paging([Result])
    case populated([Result])
    case empty
    case error(Error)

    var currentResults: [Result] {
        switch self {
        case .paging(let results):
            return results
        case .populated(let results):
            return results
        default:
            return []
        }
    }
}

class EnumListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "cellId"
    fileprivate let footerId = "footerId"

    var state = DataState.loading {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)

        fetchData()
    }

    fileprivate let searchTerm = "BTS"

    fileprivate func fetchData() {
        state = .loading

        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
            if let err = err {
                print("Failed to paginate data:", err)
                return
            }

            if let results = searchResult?.results {
                self.state = .populated(results)
            } else {
                self.state = .empty
            }
        }
    }


    fileprivate func loadPage() {
        state = .paging(state.currentResults)
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(state.currentResults.count)&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
            if let err = err {
                self.state = .error(err)
                return
            }

            if searchResult?.results.count == 0 {
                self.state = .empty
                return
            }

            sleep(2)

            var allResults = self.state.currentResults
            allResults += searchResult?.results ?? []
            self.state = .populated(allResults)
        }
    }


    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var height: CGFloat =  0
        if case .paging(_) = state {
            height = 100
        }

        return .init(width: view.frame.width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.currentResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListCell

        let track = state.currentResults[indexPath.item]
        cell.configure(viewData: track)

        if case .populated(_) = state,
           indexPath.item == state.currentResults.count - 1 {
            loadPage()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }

}


