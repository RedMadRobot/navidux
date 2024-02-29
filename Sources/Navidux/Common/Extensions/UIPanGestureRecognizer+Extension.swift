import UIKit

extension UIPanGestureRecognizer {
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)

        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }

    // На основе смещения и его скорости рассчитываем, хотел ли пользователь закрыть экран.
    func isProjectedToDownHalf(maxTranslation: CGFloat, percentComplete: CGFloat) -> Bool {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let verticalTranslation = maxTranslation * percentComplete
        let translation = CGPoint(x: 0, y: verticalTranslation) + velocityOffset

        let isPresentationCompleted = translation.y > maxTranslation / 2
        return isPresentationCompleted
    }
}
