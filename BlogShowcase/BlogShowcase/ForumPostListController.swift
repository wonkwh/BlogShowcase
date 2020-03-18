//
//  ForumPostListController.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/18.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import LBTATools
import Nuke

class ForumListCell: UICollectionViewCell {
    let nameLabel: UILabel = {
        let view = UILabel(text: "Title", font: .boldSystemFont(ofSize: 18))
        view.isSkeletonable = true
        return view
    }()

    let subtitleLabel = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)

        [nameLabel, subtitleLabel].forEach { view in
            view.isSkeletonable = true
        }

        stack(nameLabel, subtitleLabel, spacing: 4).withMargins(.allSides(10))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class ForumPostListController: UIViewController {
    var dataSource: DataSource!

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()

    private var posts = [ThreadPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        dataSource.state = forEach(posts) { post in
            Cell<ForumListCell>() { context, cell in
                cell.nameLabel.text = post.title
            }
            .onNextPage{ _ in
                let urlString = "https://\(self.domain).vingle.network/api/forums/\(self.channel)/threads?parentId=\(self.channel)&sort=general"
                let task = URLSession.shared.postListTask(with: URL(string: urlString)!) { postList, response, error in
                    if let err = error {
                        print("Failed to paginate data:", err)
                        return
                    }

                    self.posts += postList?.data ?? []
                    DispatchQueue.main.async {
                        self.setDataSource()
                    }
                }
                task.resume()
            }
            .onSelect { context in
                print("cell at index \(context.indexPath.item) is selected")
            }
            .onSize { context -> CGSize in
                return .init(width: self.collectionView.frame.width, height: 72.0)
            }
        }
    }


    fileprivate let domain = "iostestgroup1"
    fileprivate let channel = "CUNGAHTWJ"

    fileprivate func fetchData() {
        let urlString = "https://\(domain).vingle.network/api/forums/\(channel)/threads?parentId=\(channel)&sort=general"
        let task = URLSession.shared.postListTask(with: URL(string: urlString)!) { postList, response, error in
            if let err = error {
                print("Failed to paginate data:", err)
                return
            }

            self.posts = postList?.data ?? []
            DispatchQueue.main.async {
                self.setDataSource()
            }
        }
        task.resume()
    }
}


