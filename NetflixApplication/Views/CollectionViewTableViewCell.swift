//
//  CollectionViewTableViewCell.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-11.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}



// Customer Resuable Table View Cell 
class CollectionViewTableViewCell: UITableViewCell {
    
    static let indetifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var titles: [Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        
        // Setting the layout horizontal scroll and accmodating each item to contain in full height
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]){
        self.titles =  titles
        
        //
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        DataPersistanceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            switch result {
            case.success():
                // POst an notiication once an item has been downloaded to alert user
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}


//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else  {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {
           return UICollectionViewCell()
        }
        cell.configure(with: model)
        // Added corner radius to the cells
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        
        // Passing the query for the title and calling the youtube API reponse to get the videoId
        APICaller.share.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result{
            case .success(let videoElement):
                
                
                let title = self?.titles[indexPath.row]
                guard let titleOverView = title?.overview else { return }
                guard let strongSelf = self else { return }
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverView)
                self?.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    internal func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil , state: .off) { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", subtitle: nil, image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        return config
    }
    
    

    
}


