//
//  PullBar.swift
//
//
//  Created by Oleg Krasnov on 08/11/2023.
//

import UIKit

// TODO: - Возможно нужно подумать о том, чтобы  автоматически добавлять pull bar к bottom sheet.
// Сейчас нужно добавлять на каждый экран отдельно
open class PullBar: UIView {
    
    private let topCornerRadius: Int
    private let icon: UIImage?
    private let iconSize: CGSize
    private let pullBarBackgroundColor: UIColor
    
    private lazy var imageView = UIImageView(image: icon) // TODO: Добавить нужное изображение для иконки пуллбара
    
    public init(
        topCornerRadius: Int = 20,
        icon: UIImage? = .pullBarIcon,
        iconSize: CGSize = .init(width: 48, height: 4),
        pullBarBackgroundColor: UIColor = .white
    ) {
        self.topCornerRadius = topCornerRadius
        self.icon = icon
        self.iconSize = iconSize
        self.pullBarBackgroundColor = pullBarBackgroundColor
        super.init(frame: .zero)
        setupUI()
    }

    public required init?(coder: NSCoder) { nil }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners:[.topRight, .topLeft],
            cornerRadii: CGSize(
                width: topCornerRadius,
                height:  topCornerRadius
            )
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    open func setupUI() {
        backgroundColor = pullBarBackgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: iconSize.width),
            imageView.heightAnchor.constraint(equalToConstant: iconSize.height),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
