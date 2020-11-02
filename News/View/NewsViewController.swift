//
//  ViewController.swift
//  News
//
//  Created by Diana Agapkina on 10/29/20.
//

import UIKit
import CoreLocation
import SafariServices

class NewsViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var viewBar: UIView!
    
    private var newsItems = [NewsItem]()
    var cellScale: CGFloat = 0.65
    
    lazy var presenter: INewsListPresenter = NewsListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBar.layer.cornerRadius = 40
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        loadData()
        
        newsCollectionView.dataSource = self
    }
    
    @objc func willEnterForeground() {
        loadData()
    }
    
    // MARK: - Private Methods
    private func loadData() {
        presenter.loadData { [weak self] (error) in
            DispatchQueue.main.async {
                if error != nil {
                    self?.alertNoConnection()
                }
                self?.newsCollectionView.reloadData()
            }
        }
    }
    
    private func alertNoConnection() {
        let alert = UIAlertController(title: "Warning ⚠️",
                                      message: "Please, turn on the Internet to view the news.",
                                      preferredStyle: .alert)
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension NewsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.8
        let height = width * 8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.feedsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,                                              for: indexPath) as! NewsCell

        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.configure(with: presenter.feedItem(at: indexPath.row))
        
        return cell
    }
}


