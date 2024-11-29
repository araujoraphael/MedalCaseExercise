//
//  MedalCaseViewController.swift
//  MedalCaseExercise
//
//  Created by Raphael Araújo on 2024-11-26.
//

import UIKit

class MedalCaseViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    private var collectionViews: [UICollectionView] = []
    private var viewModel = MedalCaseViewModel()
    
    struct Constants {
        static let itemHeight: CGFloat = 160
        static let sectionHeaderHeight: CGFloat = 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        setupCollectionView()

        viewModel.update()
    }
    
    func refreshMedals() {
        mainCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        registerCells()
        configureCollectionViewLayout()
        configureCollectionViewDelegates()
        setupNavigationBarAppearance()
    }

    private func registerCells() {
        mainCollectionView.register(UINib(nibName: "MedalCaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MedalCaseCollectionViewCell")
    }

    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: Constants.sectionHeaderHeight)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: Constants.itemHeight)
        
        mainCollectionView.collectionViewLayout = layout
    }

    private func configureCollectionViewDelegates() {
        mainCollectionView.dataSource = viewModel
        mainCollectionView.delegate = viewModel
    }

    private func setupNavigationBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.highlight
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.navigationTitle]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationTitle]

        let navBarAppearanceWhenContained = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navBarAppearanceWhenContained.standardAppearance = navBarAppearance
        navBarAppearanceWhenContained.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
