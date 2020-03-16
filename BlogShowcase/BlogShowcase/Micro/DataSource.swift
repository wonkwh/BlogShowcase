//
//  DataSource.swift
//  Micro
//
//  Created by khoa on 08/02/2020.
//  fixed emptyView and pagination by kwanghyun.won

import UIKit

open class DataSource: NSObject {
    private var cellRegister: Set<String> = Set()
    internal var trueState: State = .init()
    public weak var collectionView: UICollectionView?
    public var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "please enter the search term..."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.isHidden = true
        return label
    }()


    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.addSubview(self.emptyStateLabel)
        self.emptyStateLabel.centerInSuperview()
    }

    public var state: State {
        get {
            trueState
        }
        set {
            reload(newState: newValue)
        }
    }

    public func reload(
        newState: State,
        isAnimated: Bool = true,
        completion: Reloader.Completion? = nil
    ) {
        guard let collectionView = collectionView else { return }
        let request = Reloader.Request(
            dataSource: self,
            collectionView: collectionView,
            newState: newState,
            isAnimated: isAnimated,
            completion: completion ?? { _ in }
        )
        newState.reloader.onReload(request)
    }

    public func registerIfNeeded<Cell: UICollectionViewCell>(
        collectionView: UICollectionView,
        cellType: Cell.Type
    ) {
        if !cellRegister.contains(String(describing: cellIdentifier(cellType))) {
            collectionView.register(cellType: cellType)
            cellRegister.insert( cellIdentifier(cellType))
        }
    }
}

extension DataSource: UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyStateLabel.isHidden = state.models.count > 0 ? true : false
        return state.models.count
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)

        // FIXME - pagination
        if indexPath.item == state.models.count - 5 {
            observer?.onNextPage(context)
        }

        return observer?.onConfigure(context, self) ?? UICollectionViewCell()
    }
}

extension DataSource: UICollectionViewDelegate {
    open func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        observer?.onWillDisplay(context, cell)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        observer?.onDidEndDisplay(context, cell)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        return observer?.onShouldSelect(context) ?? false
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        observer?.onSelect(context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        observer?.onDeselect(context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        shouldHighlightItemAt indexPath: IndexPath
    ) -> Bool {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        return observer?.onShouldHighlight(context) ?? false
    }
}

extension DataSource: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let observer = state.observers[safe: indexPath.item]
        let context = Context(collectionView: collectionView, indexPath: indexPath)
        return observer?.onSize(context) ?? .zero
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let observer = state.observers[safe: 0]
        let context = Context(collectionView: collectionView, indexPath: IndexPath(item: 0, section: section))
        return observer?.onFooterSize(context) ?? .zero
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let observer = state.observers[safe: 0]
        let context = Context(collectionView: collectionView, indexPath: IndexPath(item: 0, section: section))
        return observer?.onHeaderSize(context) ?? .zero
    }
}
