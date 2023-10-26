//
//  WheelViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class WheelViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundWheel.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var fortunaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.fortuna.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showWinViewController), userInfo: nil, repeats: false)
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, fortunaImage].forEach() {
            view.addSubview($0)
        }
        startRotationAnimation()
    }
    
    // MARK: - setupConstraints

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        fortunaImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    private func startRotationAnimation() {
        let fullRotation = CGFloat(Double.pi * 2)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = fullRotation
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .greatestFiniteMagnitude
        self.fortunaImage.layer.add(rotationAnimation, forKey: "360rotation")
    }
    
    @objc private func showWinViewController() {
        let controller = WinViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

