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

    private var viewModels: [Any] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var presenter: LifeScreenPresentation?
    private var layout = PinterestLayout()
    var images: [SingleImageItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateData()
        configureCollectionView()
        

        // Do any additional setup after loading the view.
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateData() {
        images = (1...200).map({ _ in SingleImageItem.generateDumyImage() })
    }
    

    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: PhotoItemCell.reuseIdentifer)
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
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.reuseIdentifer, for: indexPath) as! PhotoItemCell
        
        cell.photoURL = images[indexPath.row].thumbnail?.url
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
        let image = images[indexPath.row]
        guard let width = image.thumbnail?.width, let height = image.thumbnail?.height else { return .zero }
        let cellWidth = layout.width
        let size = CGSize(width: Int(cellWidth), height: Int((height/width) * cellWidth))
        return size
    }
}


// MARK: - LifeScreenViewable
extension LifeScreenViewController: LifeScreenViewable {
    
}
