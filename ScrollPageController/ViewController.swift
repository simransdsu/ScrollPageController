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
        
        loadImageViews()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count),
                                        height: scrollView.frame.size.height)
    }
    
    
    var imageViews: [UIImageView] = []
    
    private func loadImageViews() {
        
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        imageViews.removeAll()
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size

            let imageView = UIImageView()
           
//            if index == pageControll.currentPage {
//                frame.size.width = frame.size.width * 1.1
//                frame.size.height = frame.size.height * 1.1
//            }
            
            imageView.frame = frame
            
            imageView.image = UIImage(named: images[index])
            imageView.contentMode = .scaleAspectFit
            
            imageViews.append(imageView)
            self.scrollView.addSubview(imageView)
        }
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
        scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width * CGFloat(pageControll.currentPage),
                                              y: 0,
                                              width: scrollView.frame.width,
                                              height: scrollView.frame.height),
                                       animated: true)
        loadImageViews()
    }
    
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pagenumberr = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControll.currentPage = Int(pagenumberr)
        loadImageViews()
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(pageControll.currentPage, " : ", scrollView.contentOffset.x)
//
//        if pageControll.currentPage == 0 {
//            let currentImageView = imageViews[pageControll.currentPage]
//            let nextImageView = imageViews[pageControll.currentPage + 1]
//
//            currentImageView.alpha = 1.0 - (0.001 * CGFloat(scrollView.contentOffset.x))
//        }
//
//        if pageControll.currentPage == imageViews.count - 1 {
//            let currentImageView = imageViews[imageViews.count - 1]
//            let prevImageView = imageViews[pageControll.currentPage]
//
//            currentImageView.alpha += 0.001 * CGFloat(scrollView.contentOffset.x)
//        }
//    }
}
