//
//  MedalCaseCollectionViewCell.swift
//  MedalCaseExercise
//
//  Created by Raphael Araújo on 2024-11-27.
//

import UIKit

class MedalCaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    struct Constants {
        static let itemHeight: CGFloat = 160
    }
    
    var medals: [Medal] = [] {
        didSet {
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "MedalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MedalCollectionViewCell")
            
            refreshMedals()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func refreshMedals() {
        collectionView.reloadData()
        collectionView.collectionViewLayout = createHorizontalLayout(itemCount: medals.count)
        updateEmbeddedCollectionViewHeight()
    }
    
    private func createHorizontalLayout(itemCount: Int) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let screenWidth = layoutEnvironment.container.effectiveContentSize.width
            let itemWidth = screenWidth / 2
            let itemHeight = Constants.itemHeight
            let rows = 3

            let horizontalPadding = self.calculateHorizontalPadding(screenWidth: screenWidth, itemWidth: itemWidth)
            
            let item = self.createItemLayout(itemWidth: itemWidth, itemHeight: itemHeight)
            let rowGroup = self.createRowGroup(item: item, itemWidth: itemWidth, itemHeight: itemHeight)
            let pageGroup = self.createPageGroup(rowGroup: rowGroup, rows: rows, itemWidth: itemWidth, itemHeight: itemHeight)

            let section = self.createSection(pageGroup: pageGroup, itemCount: itemCount, itemWidth: itemWidth, horizontalPadding: horizontalPadding)

            return section
        }
    }

    private func calculateHorizontalPadding(screenWidth: CGFloat, itemWidth: CGFloat) -> CGFloat {
        let totalItemWidth = itemWidth * 2
        return (screenWidth - totalItemWidth) / 2
    }

    private func createItemLayout(itemWidth: CGFloat, itemHeight: CGFloat) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        return item
    }

    private func createRowGroup(item: NSCollectionLayoutItem, itemWidth: CGFloat, itemHeight: CGFloat) -> NSCollectionLayoutGroup {
        let rowGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth * 2), heightDimension: .absolute(itemHeight))
        return NSCollectionLayoutGroup.horizontal(layoutSize: rowGroupSize, subitem: item, count: 2)
    }

    private func createPageGroup(rowGroup: NSCollectionLayoutGroup, rows: Int, itemWidth: CGFloat, itemHeight: CGFloat) -> NSCollectionLayoutGroup {
        let pageGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth * 2), heightDimension: .absolute(itemHeight * CGFloat(rows) + 8))
        return NSCollectionLayoutGroup.vertical(layoutSize: pageGroupSize, subitems: Array(repeating: rowGroup, count: rows))
    }

    private func createSection(pageGroup: NSCollectionLayoutGroup, itemCount: Int, itemWidth: CGFloat, horizontalPadding: CGFloat) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: pageGroup)

        let itemsPerPage = 6 // 3 rows * 2 items
        let remainingItems = itemCount % itemsPerPage
        let trailingInset: CGFloat = (remainingItems > 0 && remainingItems < 2) ? itemWidth : 0

        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: horizontalPadding, bottom: 0, trailing: horizontalPadding + trailingInset)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func updateEmbeddedCollectionViewHeight() {
        collectionView.layoutIfNeeded()
        
        let totalItems = medals.count
        
        let rows = min(ceil(CGFloat(totalItems) / 2), 3)
        let contentHeight = rows * Constants.itemHeight
        
        collectionViewHeightConstraint.constant = contentHeight
    }
}

extension MedalCaseCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedalCollectionViewCell", for: indexPath) as? MedalCollectionViewCell
        else { return UICollectionViewCell() }
        
        let medal = medals[indexPath.item]
        
        cell.medal = medal
        
        return cell
    }
}
