// https://habr.com/ru/companies/koshelek/articles/703260/
import UIKit

// TODO: - тут наверное нужно рефакторить в будущем т.к. старт закрытия должен происходить в том месте, где происходит логика переходов между экранами
final class BSTransitionDriver: UIPercentDrivenInteractiveTransition {
    private weak var presentedController: UIViewController?
    
    // Максимальное расстояние, на которое можно сместить презентованный контроллер — это высота контроллера,
    // поэтому используем её как максимально возможное смещение
    private var maxTranslation: CGFloat? {
        let height = presentedController?.view.frame.height ?? 0
        return height > 0 ? height : nil
    }
    
    // Жест, который будет отслеживать движение пальца.
    // Так мы сможем посчитать прямую зависимость между длиной сдвига и процентом анимации.
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let panRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleDismiss)
        )
        panRecognizer.delegate = self
        return panRecognizer
    }()
    
    // В случае, если этот флаг false, даёт возможность воспроизвести интерактивную анимацию как обычную.
    // По умолчанию всегда true.
    // Если не добавить условие интерактивного старта, то, при нажатии в область затемнения, анимация транзишена будет перехвачена driver’ом и остановится в стартовой позиции в ожидании дальнейших команд.
    // Добавляем условие, чтобы интерактивным транзишен становился только в случае, если случился жест свайпа.
    override var wantsInteractiveStart: Bool {
        get {
            panRecognizer.state == .began
        }
        set {
            super.wantsInteractiveStart = newValue
        }
    }
    
    init(controller: UIViewController) {
        super.init()
        
        controller.view.addGestureRecognizer(panRecognizer)
        presentedController = controller
    }

    @objc
    private func handleDismiss(_ sender: UIPanGestureRecognizer) {
        guard let maxTranslation = maxTranslation else { return }
        switch sender.state {
        case .began:
            let isRunning = percentComplete != 0
            // Чтобы избежать сбоев, проверяем, что анимация ещё не запущена другим способом.
            if !isRunning {
              presentedController?.dismiss(animated: true)
            }

            // На старте интерактивного транзишена анимация уже находится в состоянии паузы,
            // но если пользователь свайпнет и сразу передумает, то сможет поймать закрытие и поставить на паузу
            pause()

        case .changed:
            // На каждый шаг смещения будем обновлять процент анимации через update(_:) до момента,
            // пока пользователь не поднимет палец.
            let increment = sender.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)

        case .ended, .cancelled:
            // Когда жест будет завершён или отменён, нужно будет рассчитать, как поступить с транзишеном.
            // Если смещение было больше половины или скорость смещения можно расценивать как быстрый свайп вниз, тогда мы вызываем finish() и транзишен закрытия завершается анимированно.
            // В противном случае отменяем транзишен и экран остаётся открытым.
            if sender.isProjectedToDownHalf(
                maxTranslation: maxTranslation,
                percentComplete: percentComplete
            ) {
                finish()
            } else {
                cancel()
            }

        case .failed:
            cancel()

        default:
            break
        }
    }
}

extension BSTransitionDriver: UIGestureRecognizerDelegate {
    // Жест будет обработан, если его скорость по оси Y больше 0, то есть направлен вниз, и скорость по оси Y больше чем X, чтобы не реагировать на боковые свайпы.
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = panRecognizer.velocity(in: nil)
        if velocity.y > 0, abs(velocity.y) > abs(velocity.x) {
            return true
        } else {
            return false
        }
    }
}
