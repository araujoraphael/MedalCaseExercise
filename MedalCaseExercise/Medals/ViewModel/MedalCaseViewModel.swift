//
//  MedalCaseViewModel.swift
//  MedalCaseExercise
//
//  Created by Raphael Araújo on 2024-11-27.
//

import Foundation
import UIKit

protocol MedalCaseViewModelProtocol {
    func update()
}

class MedalCaseViewModel: NSObject, MedalCaseViewModelProtocol {
    
    private var medalsUseCase: MedalsUseCaseProtocol = MedalsUseCase()
    private var medalsCase: MedalsCaseModel?
    private var medalsPerType: [Int: [Medal]] = [:]

    weak var view: MedalCaseViewController?
    
    struct Constants {
        static let itemHeight: CGFloat = 160
    }
    
    func update() {
        medalsUseCase.fetchMedals {[weak self] result in
            switch result {
            case .success(let medals):
                DispatchQueue.main.async {
                    self?.medalsCase = medals
                    
                    for (index, medalType) in medals.medalTypes.enumerated() {
                        let matchingMedals = medals.medals.filter({$0.type == medalType})
                        self?.medalsPerType[index] = matchingMedals
                    }
                    
                    self?.view?.refreshMedals()
                }
            case .failure(let error):
                debugPrint(">>> Error: \(error)")
            }
        }
    }
    
    private func calculateEmbeddedCollectionViewHeight(for indexPath: IndexPath) -> CGFloat {
        let numberOfItems = medalsPerType[indexPath.section]?.count ?? 0
        let rows = min(ceil(CGFloat(numberOfItems) / 2), 3)
        let itemHeight = Constants.itemHeight
        let height = rows * CGFloat(itemHeight)
        return height
    }
    
    private func sectionTitle(for section: Int) -> String {
        guard medalsPerType[section]?.isEmpty == false else { return "" }

        guard let medalType = medalsCase?.medalTypes[section] else { return "" }
        
        var title: String
        
        switch medalType {
        case .personalRecords:
            title = "Personal Records"
        case .virtualRaces:
            title = "Virtual Races"
        }
        
        return title
    }
}

extension MedalCaseViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedalCaseCollectionViewCell", for: indexPath) as? MedalCaseCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        guard let medals = medalsPerType[indexPath.section]
        else {
            return UICollectionViewCell()
        }
        
        cell.medals = medals
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return medalsPerType.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MedalCaseSectionHeaderView", for: indexPath)
            
            guard let sectionHeaderView = headerView as? MedalCaseSectionHeaderView else { return headerView }
            
            sectionHeaderView.titleLabel.text = sectionTitle(for: indexPath.section)
            sectionHeaderView.pageLabel.text = "1/2"
            sectionHeaderView.backgroundColor = UIColor(named: "sectionHeaderBG")

            return sectionHeaderView
        default:
            return UICollectionReusableView()
        }
    }
}

extension MedalCaseViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let embeddedCollectionViewHeight = calculateEmbeddedCollectionViewHeight(for: indexPath) + 20
            return CGSize(width: collectionView.bounds.width, height: embeddedCollectionViewHeight)
    }
}
