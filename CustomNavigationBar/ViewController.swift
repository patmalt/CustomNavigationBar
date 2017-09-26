//
//  ViewController.swift
//  CustomNavigationBar
//
//  Created by Patrick Maltagliati on 9/26/17.
//  Copyright © 2017 Patrick Maltagliati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let color: UIColor
    
    init(color: UIColor = .cyan) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
        title = String(describing: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = color
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func tap() {
        let viewController = ViewController(color: randonColor())
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func randonColor() -> UIColor {
        let colors: [UIColor] = [.black, .darkGray, .lightGray, .white, .gray, .green,
                                 .blue, .cyan, .yellow, .magenta, .orange, .purple, .brown]
        return colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }
}
