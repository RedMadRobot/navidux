// https://habr.com/ru/companies/koshelek/articles/703260/
import UIKit

final class CoverVerticalDismissAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    private let duration: TimeInterval = 0.35
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = makeAnimator(using: transitionContext)
        animator?.startAnimation()
    }
    
    func interruptibleAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        makeAnimator(using: transitionContext) ?? UIViewPropertyAnimator()
    }

    // MARK: Private
    private func makeAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating? {
        guard let fromView = transitionContext.view(forKey: .from)
        else {
            return nil
        }

        let animator = UIViewPropertyAnimator(
            duration: duration,
            controlPoint1: CGPoint(x: 0.2, y: 1),
            controlPoint2: CGPoint(x: 0.42, y: 1)
        ) {
            fromView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: fromView.frame.height)
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}
