//
//  HomeViewController.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-10.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {

    let  sectionTitles: [String] = ["Trending Movies", "Popular", "Trending Tv Shows", "Upcoming Movies", "Top Rate"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.indetifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        // The delegate property is often used to assign an object that will handle events and behavior for another object.
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        // The main header for our home page
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    
    // Implementing the Netflix Logo Icon in our Top Navigation bar
    private func configureNavBar(){
        var image = UIImage(named: "netflixLogo")
        
        /* making sure image does not change the originality, forcing
         change the size of the image to be fitted within the navigation bar and proper alignment
        */
        let desiredSize = CGSize(width: 30, height: 30)

        if let originalImage = image {
            let aspectFitRect = AVMakeRect(aspectRatio: originalImage.size, insideRect: CGRect(origin: .zero, size: desiredSize))
            image = UIGraphicsImageRenderer(size: desiredSize).image { _ in
                originalImage.draw(in: aspectFitRect, blendMode: .normal, alpha: 1.0)
            }.withRenderingMode(.alwaysOriginal)
        }
        
        navigationItem.leftBarButtonItem  = UIBarButtonItem(image: image,  style: .done, target: self, action: nil)
        
        
        // Mutiple items to the right side of the top navigation
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}




//MARK: UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // One section returns many rows - One section has one Row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Downcasting as CollectionViewTableViewCell for customer cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.indetifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
    // Specification for the height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    
    // Allowing the top navigation bar to stick the top when scrolled
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffest = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffest
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}
