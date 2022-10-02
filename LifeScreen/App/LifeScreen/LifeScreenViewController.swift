//
//  LifeScreenViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit

/// Протокол управления View-слоем в модуле LifeScreen
protocol LifeScreenViewable: AnyObject {
    
}

class LifeScreenViewController: UICollectionViewController {

    private var viewModels: [EventCollageCellViewModelProtocol] = [] {
        didSet {
            print("Обновили CollectionView")
            collectionView.reloadData()
        }
    }
    
    var presenter: LifeScreenPresentation?
    private var layout = PinterestLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        getViewModels()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        collectionView.register(EventCollageCell2.self, forCellWithReuseIdentifier: EventCollageCell2.reuseId)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        // Set columns count
        layout.columnsCount = 2
        layout.delegate = self
        layout.contentPadding = PinterestLayout.Padding(horizontal: 10, vertical: 10)
        layout.cellsPadding = PinterestLayout.Padding(horizontal: 10, vertical: 10)

        collectionView.setContentOffset(CGPoint.zero, animated: false)
        collectionView.reloadData()
        print("Настройка")
    }
    
    func getViewModels() {
        
        presenter?.getViewModels(competion: { [weak self] result in
            switch result {
            case .success(let viewModels):
                self?.viewModels = viewModels
                print("получили viewModels")
            case .failure(let error):
                // Обрабатываем View-слоем полученную ошибку
                print(error.localizedDescription)
            }
        })
        
        print("Обновили ViewModels")
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollageCell2.reuseId, for: indexPath) as! EventCollageCell2
        
//        cell.photoURL = images[indexPath.row].thumbnail?.url
        cell.configure(viewModel)
        return cell
    }
}

//// MARK: UICollectionViewDelegateFlowLayout
//extension LifeScreenViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 50, height: 50)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
//}
// MARK: - PinterestLayoutDelegate
extension LifeScreenViewController: PinterestLayoutDelegate {
    func cellSize(indexPath: IndexPath) -> CGSize {
        // Calculate size based on the layout width
        let viewModel = viewModels[indexPath.row]
        let width = viewModel.width
        let height = viewModel.height
        let cellWidth = layout.width
        let size = CGSize(width: Int(cellWidth), height: Int((height/width) * cellWidth))
        return size
    }
}


// MARK: - LifeScreenViewable
extension LifeScreenViewController: LifeScreenViewable {
    
}
