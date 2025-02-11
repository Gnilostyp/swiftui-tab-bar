//
//  Created by Vlad Gnilozub on 21.02.24.
//

import SwiftUI

struct HideableView<Content: View>: UIViewRepresentable {
    @Binding var isHidden: Bool
    var view: Content

    func makeUIView(context: Context) -> ViewContainer<Content> {
        return ViewContainer(isContentHidden: isHidden, child: view)
    }

    func updateUIView(_ container: ViewContainer<Content>, context: Context) {
        container.child.rootView = view
        container.isContentHidden = isHidden
    }

    class ViewContainer<ChildView: View>: UIView {
        var child: UIHostingController<ChildView>
        var didShow = false
        var isContentHidden: Bool {
            didSet {
                addOrRemove()
            }
        }

        init(isContentHidden: Bool, child: ChildView) {
            self.child = UIHostingController(rootView: child)
            self.isContentHidden = isContentHidden
            super.init(frame: .zero)
            addOrRemove()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            child.view.frame = bounds
        }

        func addOrRemove() {
            if isContentHidden && child.view.superview != nil {
                child.view.removeFromSuperview()
            }
            if !isContentHidden && child.view.superview == nil {
                if !didShow {
                    DispatchQueue.main.async {
                        if !self.isContentHidden {
                            self.addSubview(self.child.view)
                            self.didShow = true
                        }
                    }
                } else {
                    addSubview(child.view)
                }
            }
        }

    }
}
