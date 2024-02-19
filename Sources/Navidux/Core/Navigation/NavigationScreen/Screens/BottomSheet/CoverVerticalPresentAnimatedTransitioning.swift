// https://habr.com/ru/companies/koshelek/articles/703260/
import UIKit

final class CoverVerticalPresentAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    // Стандартное время транзишена в iOS — 0.35.
    private let duration: TimeInterval = 0.35
    
    // Перед стартом анимации UIKit запросит время анимации транзакции открытия экрана.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    // Перед стартом транзишена UIKit вызовет этот метод с контекстом, в котором хранится необходимая информации об участниках.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = makeAnimator(using: transitionContext)
        animator?.startAnimation()
    }

    private func makeAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating? {
        guard let toView = transitionContext.view(forKey: .to)
        else {
            return nil
        }

        // Анимация построена на смещении view по y из-за нижней границы экрана, поэтому для начала принудительно обновляем layout view контроллера.
        // Так как размеры и положение у нас заданы в BSPresentationController с помощью констрейнтов, то layoutIfNeeded спровоцирует UIKit на перерасчёт.
        let containerView = transitionContext.containerView
        containerView.layoutIfNeeded()

        // Смещаем view вниз за экран на его же высоту до старта анимации с помощью трансформации.
        toView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: toView.frame.height)

        let animator = UIViewPropertyAnimator(
            duration: duration,
            controlPoint1: CGPoint(x: 0.2, y: 1),
            controlPoint2: CGPoint(x: 0.42, y: 1)
        ) {
            // В блоке аниматора вернём view к исходному положению.
            toView.transform = .identity
        }

        animator.addCompletion { _ in
            // После завершения анимации необходимо вызвать у контекста метод completeTransition(_ didComplete:) для индикации, что все анимации завершены со значением true, если анимация не была прервана.
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}


