// https://habr.com/ru/companies/koshelek/articles/703260/
import UIKit

final class BSPresentationController: UIPresentationController {

    var sheetSize: BSSize = .auto
    
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        return recognizer
    }()

    override var shouldPresentInFullscreen: Bool {
        false
    }

    // Этот метод UIKit вызовет перед стартом презентации.
    // Расположит презентуемый контроллер в containerView presentation controller’а.
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView,
              let presentedView = presentedView
        else { return }
        
        [dimmView, presentedView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }

        dimmView.alpha = 0
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 1
        }
        
        var constraints: [NSLayoutConstraint] = [
            presentedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            presentedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            presentedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            dimmView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        
        switch sheetSize {
        case .fixed(let height):
            constraints.append(
                presentedView.heightAnchor.constraint(equalToConstant: height)
            )
        case .halfScreen:
            constraints.append(
                presentedView.heightAnchor.constraint(
                    lessThanOrEqualTo: containerView.heightAnchor,
                    constant: -(containerView.bounds.height / 2)
                )
            )
        case .auto:
            constraints.append(
                presentedView.heightAnchor.constraint(
                    lessThanOrEqualTo: containerView.heightAnchor,
                    constant: -containerView.safeAreaInsets.top
                )
            )
        case .fullScreen:
            break
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // Удаляем subviews из контейнера, если транзишен был прерван.
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmView.removeFromSuperview()
            presentedView?.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 0
        }
    }
    
    private func performAlongsideTransitionIfPossible(_ animation: @escaping () -> Void ) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            animation()
            return
        }
        
        coordinator.animate { _ in
            animation()
        }
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}

