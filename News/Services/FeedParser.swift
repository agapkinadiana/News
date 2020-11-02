//
//  FeedParser.swift
//  News
//
//  Created by Diana Agapkina on 10/29/20.
//

import Foundation

class FeedParser: NSObject {
    private var newsItems: [NewsItem] = []
    private var currentElement: String?
    private var currentTitle = ""
    private var currentImageURL = ""
    private var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            currentDescription = currentDescription.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
    }
    
    private var callbackClosure: ((_ feed: [NewsItem], _ error: NSError?) -> Void)?
    
    func parseFeedFromData(_ data: Data?, callback: @escaping (_ feed: [NewsItem], _ error: NSError?) -> Void) {
        
        self.callbackClosure = callback
        
        let parser = XMLParser(data: data!)
        parser.delegate = self
        parser.parse()
    }
}


extension FeedParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentImageURL = ""
            currentDescription = ""
        }
        
        if currentElement == "media:content" && attributeDict["type"] == "image/jpeg" {
            if let imageURL = attributeDict["url"] {
                currentImageURL = imageURL
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "title": currentTitle += string
            case "description": currentDescription += string
            default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let newsItem = NewsItem(title: currentTitle, imageURL: currentImageURL, details: currentDescription)
            self.newsItems.append(newsItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        callbackClosure?(newsItems, nil)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
