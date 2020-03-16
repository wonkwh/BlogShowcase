//
//  Extensions.swift
//  Micro
//
//  Created by khoa on 08/02/2020.
//

import UIKit

func cellIdentifier<Cell: UICollectionViewCell>(_ cellType: Cell.Type) -> String {
    return String(describing: Cell.self)
}

func viewIdentifier<View: UICollectionReusableView>(_ viewType: View.Type) -> String {
    return String(describing: View.self)
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(T.self, forCellWithReuseIdentifier: cellIdentifier(cellType))
    }

    func register<T: UICollectionReusableView>(viewType: T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewIdentifier(viewType))
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(
            withReuseIdentifier:cellIdentifier(T.self),
            for: indexPath
        ) as? T
    }

    func dequeue<T: UICollectionReusableView>(for indexPath: IndexPath, kind: String) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewIdentifier(T.self), for: indexPath) as? T
    }
}

extension Collection {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
