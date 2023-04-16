//
//  CircularProgressBarView.swift
//  RehApp
//
//  Created by Akademija on 16.04.2023..
//

import Foundation
import UIKit

final class CircularProgressBarView: UIView {

    // MARK: - Properties

    private let circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.strokeEnd = 1
        layer.strokeColor = UIColor.darkPurple.withAlphaComponent(0.2).cgColor
        return layer
    }()

    private let progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.green.cgColor
        return layer
    }()

    let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)

    private let radius: CGFloat
    private let barWidth: CGFloat

    // MARK: - Init

    init(radius: CGFloat, barWidth: CGFloat) {
        self.radius = radius
        self.barWidth = barWidth
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        circleLayer.frame = bounds
        progressLayer.frame = bounds
        let arcCenter = CGPoint(x: circleLayer.frame.size.width / 2,
                                y: circleLayer.frame.size.height / 2)
        let circularPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        circleLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }

    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        circleLayer.lineWidth = barWidth
        progressLayer.lineWidth = barWidth

        addSubview(counterLabel)
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)

        NSLayoutConstraint.activate([
            counterLabel.topAnchor.constraint(equalTo: topAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            widthAnchor.constraint(equalToConstant: CGFloat(2*(radius + barWidth))),
            heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    // MARK: - Public methods

    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = true
        progressLayer.add(circularProgressAnimation, forKey: "progressAnimation")
    }
}
