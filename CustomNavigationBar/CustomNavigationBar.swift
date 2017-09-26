
import UIKit

class CustomNavigationBar: UINavigationBar {
    private var _items: [UINavigationItem]? = []
    private var titleView: UIView?
    private weak var titleCenterXConstraint: NSLayoutConstraint?
    private weak var titleCenterYConstraint: NSLayoutConstraint?
    
    override func setItems(_ items: [UINavigationItem]?, animated: Bool) {
        if let lastItem = items?.last, let titleView = titleView(for: lastItem) {
            addSubview(titleView)
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleCenterXConstraint = titleView.centerXAnchor.constraint(equalTo: centerXAnchor)
            titleCenterXConstraint?.isActive = true
            titleCenterYConstraint = titleView.centerYAnchor.constraint(equalTo: centerYAnchor)
            titleCenterYConstraint?.isActive = true
            self.titleView = titleView
        } else {
            removeCurrentTitleView()
        }
        _items = items
    }
    
    override func pushItem(_ item: UINavigationItem, animated: Bool) {
        _items?.append(item)
        
        guard let _ = titleView, let newTitleView = self.titleView(for: item)  else {
            return
        }
        
        addSubview(newTitleView)
        newTitleView.translatesAutoresizingMaskIntoConstraints = false
        let newTitleCenterXConstraint = newTitleView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: bounds.width)
        newTitleCenterXConstraint.isActive = true
        let newTitleCenterYConstraint = newTitleView.centerYAnchor.constraint(equalTo: centerYAnchor)
        newTitleCenterYConstraint.isActive = true
        layoutIfNeeded()
        
        titleCenterXConstraint?.constant = -bounds.width
        newTitleCenterXConstraint.constant = 0
        
        let animations = { [weak self] () -> () in
            self?.layoutIfNeeded()
        }
        let completion = { [weak self] (completed: Bool) -> () in
            self?.removeCurrentTitleView()
            self?.titleView = newTitleView
            self?.titleCenterXConstraint = newTitleCenterXConstraint
            self?.titleCenterYConstraint = newTitleCenterYConstraint
        }
        
        if animated {
            UIView.animateKeyframes(withDuration: 1,
                                    delay: 0,
                                    options: [.calculationModeCubic],
                                    animations: animations,
                                    completion: completion)
        } else {
            animations()
            completion(true)
        }
    }
    
    private func titleView(for item: UINavigationItem) -> UIView? {
        if let itemTitleView = item.titleView {
            return itemTitleView
        } else if let title = item.title {
            let label = UILabel()
            label.text = title
            return label
        } else {
            return nil
        }
    }
    
    private func removeCurrentTitleView() {
        titleView?.removeFromSuperview()
        titleView = nil
    }
}
