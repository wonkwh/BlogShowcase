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

class CustomDataSource: DataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerId", for: indexPath)
        return footer
    }

}

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
        dataSource = CustomDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource

        setDataSource()
        fetchData()
    }

    var isPaginating = false
    var isDonePaginating = false

    func setDataSource() {
        dataSource.state = forEach(results) { result in
            Cell<ListCell>() { context, cell in
                cell.configure(viewData: result)

                // initiate pagination
                if context.indexPath.item == self.results.count - 5 && !self.isPaginating {
                    print("fetch more data")

                    self.isPaginating = true

                    let urlString = "https://itunes.apple.com/search?term=\(self.searchTerm)&offset=\(self.results.count)&limit=20"
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
                            self.setDataSource()
                        }
                        self.isPaginating = false
                    }
                }
            }
            .onSelect { context in
                print("cell at index \(context.indexPath.item) is selected")
            }
            .onSize { context -> CGSize in
                return .init(width: self.view.frame.width, height: 100.0)
            }
            .onFooterSize { context -> CGSize in
                let height: CGFloat = self.isDonePaginating ? 0 : 100
                return .init(width: self.view.frame.width, height: height)
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

    /*
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


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListCell

        let track = results[indexPath.item]
        cell.configure(viewData: track)
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
 */
}

