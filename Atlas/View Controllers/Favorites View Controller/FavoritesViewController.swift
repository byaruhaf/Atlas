//
//  FavoritesViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import UIKit

class FavoritesViewController: UIPageViewController {
    var pages = [UIViewController]()
    var viewModel: FavoritesViewModel?
    let initialPage = 0
//    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        style()
//        layout()
        // Register for Observer
        registerForTheme()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateColor()
    }
    
    private func setup() {
        dataSource = self
        delegate = self
                
//        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        // create an array of viewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let page1 = storyboard.instantiateViewController(withIdentifier: "FavoritesCollectionViewController")
        let page2 = storyboard.instantiateViewController(withIdentifier: "FavoritesMapViewController")

        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }

//    @objc func pageControlTapped(_ sender: UIPageControl) {
//        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
//    }
//
//    func style() {
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.currentPageIndicatorTintColor = .black
//        pageControl.pageIndicatorTintColor = .systemGray2
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = initialPage
//    }
//
//    func layout() {
//        view.addSubview(pageControl)
//
//        NSLayoutConstraint.activate([
//            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: 20),
//            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1)
//        ])
//    }
    
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// swiftlint:disable notification_center_detachment
// swiftlint:disable explicit_init
extension FavoritesViewController: ThemeableColor {
    func registerForTheme() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(colorChanged), name: NSNotification.Name.init("ColorChanged"),
            object: nil)
    }
    
    func unregisterForTheme() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func colorChanged() {
        animateColor()
    }
    
    func animateColor() {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        }
    }
}

// MARK: - DataSource
extension FavoritesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap first
        }
    }
}

// MARK: - Delegates
extension FavoritesViewController: UIPageViewControllerDelegate {
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
//        guard let viewControllers = pageViewController.viewControllers else { return }
//        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
//        pageControl.currentPage = currentIndex
    }
}
