//
//  NewsListPresenter.swift
//  News
//
//  Created by Diana Agapkina on 10/30/20.
//

import Foundation

protocol INewsListPresenter {
    func loadData(completion: @escaping (_ error: NSError?) -> Void)
    func feedItem(at index: Int) -> NewsItem
    func feedsCount() -> Int
}

protocol NewsListDelegate: class {
    func didRecieveError(_ locationManager: NewsListPresenter)
}

class NewsListPresenter: INewsListPresenter {
    private var parser = FeedParser()
    private var networkService = NetworkService()
    private var feeds: [NewsItem] = []
    
    var delegate: NewsListDelegate?
    
    func loadData(completion: @escaping (_ error: NSError?) -> Void) {
        
        let request: URLRequest = URLRequest(url: URL(string: apiURL)!)
        networkService.getDataFromRequest(request) { [weak self] (data, error) in
            if error != nil {
                print("Please check your Web connection and Feed URL!")
                completion(error as NSError?)
            }
            
            guard let data = data else {
                self?.LoadDataFromDB()
                return
            }
            
            self?.parser.parseFeedFromData(data) { [weak self] (feeds, error) in
                if error != nil {
                    print("Couldn't read that Feed, check again if URL was correct!")
                }
                
                DataBaseHelper().saveAllFeeds(items: feeds)
                self?.LoadDataFromDB()

                completion(error as NSError?)
            }
            
        }
    }
    
    func LoadDataFromDB() {
        if let news = DataBaseHelper().fetchSavedFeed() {
            self.feeds = news
        }
    }
    
    func feedItem(at index: Int) -> NewsItem {
        return feeds[index]
    }
    
    func feedsCount() -> Int {
        return feeds.count
        
    }
}
