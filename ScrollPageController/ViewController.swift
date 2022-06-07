//
//  ViewController.swift
//  ScrollPageController
//
//  Created by Simran Preet Narang on 2022-06-06.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = makeScrollView()
    lazy var pageControll: UIPageControl = makePageControl()

    
    private func commonInit() {
        
        view.addSubview(scrollView)
        view.addSubview(pageControll)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            pageControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pageControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pageControll.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12)
        ])
    }
    
    var images = ["0", "1", "2", "3", "4"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        pageControll.numberOfPages = images.count
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            print(frame)
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            imageView.contentMode = .scaleAspectFit
            self.scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count),
                                        height: scrollView.frame.size.height)
    }
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.size.width,
                                                    height: view.frame.size.width))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    private func makePageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageDotClicked), for: .valueChanged)
        return pageControl
    }
    
    @objc func pageDotClicked() {
        print(pageControll.currentPage)
        scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width * CGFloat(pageControll.currentPage),
                                              y: 0,
                                              width: scrollView.frame.width,
                                              height: scrollView.frame.height),
                                       animated: true)
    }
    
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pagenumberr = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControll.currentPage = Int(pagenumberr)
    }
}


var count = 5
var itemWidth = 200
var itemHeight = 100
var scrollViewContentWidth = itemWidth * count
var scrollViewContentHeight = 100
