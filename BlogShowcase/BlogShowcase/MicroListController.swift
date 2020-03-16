//
//  MicroListController.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/16.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import LBTATools
import Nuke

class MicroListController: UIViewController {
    var dataSource: DataSource!

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()

    var results = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(LoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerId")
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeAreaLayoutGuide()

        //micro
        dataSource = DataSource(collectionView: collectionView)
        dataSource.emptyStateLabel.text = "데이터가 없습니다."
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource

        setDataSource()
        fetchData()
    }

    func setDataSource() {
        dataSource.state = forEach(results) { result in
            Cell<ListCell>() { context, cell in
                cell.configure(viewData: result)
            }
            .onNextPage{ _ in
                let urlString = "https://itunes.apple.com/search?term=\(self.searchTerm)&offset=\(self.results.count)&limit=20"
                Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
                    if let _ = err {
                        return
                    }

                    self.results += searchResult?.results ?? []
                    DispatchQueue.main.async {
                        self.setDataSource()
                    }
                }
            }
            .onSelect { context in
                print("cell at index \(context.indexPath.item) is selected")
            }
            .onSize { context -> CGSize in
                return .init(width: self.view.frame.width, height: 100.0)
            }
        }
    }


    fileprivate let searchTerm = "IZONE"

    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in

            if let err = err {
                print("Failed to paginate data:", err)
                return
            }

            self.results = searchResult?.results ?? []
            DispatchQueue.main.async {
                self.setDataSource()
            }
        }
    }
}

