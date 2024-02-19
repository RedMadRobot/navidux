// https://habr.com/ru/companies/koshelek/articles/703260/
import UIKit

final class BSTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private var driver: BSTransitionDriver?

    // Cоздаем presentation controller.
    // Он является контейнером для презентуемого контроллера и отвечает за его положение и размеры.
    func presentationController(
        // контроллер, который хотим отобразить
        forPresented presented: UIViewController,
        // контроллер, поверх которого будет отображён презентуемый контроллер
        presenting: UIViewController?,
        // контроллер, который вызвал метод present(_:animate:completion:)
        source: UIViewController
    ) -> UIPresentationController? {
        driver = BSTransitionDriver(controller: presented)
        let presentationController = BSPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
        return presentationController
    }

    // Метод для создания анимации, с которой презентуемый контроллер будет появляться на экране.
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CoverVerticalPresentAnimatedTransitioning()
    }

    // Метод для создания анимации, с которой контроллер будет исчезать.
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CoverVerticalDismissAnimatedTransitioning()
    }
    
    // Метод для анимации закрытия при свайпе.
    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
}
