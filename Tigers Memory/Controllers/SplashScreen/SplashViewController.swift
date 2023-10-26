//
//  SplashViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundLoader.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var splashLoadingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.splashLoading.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, splashLoadingImage].forEach() {
            view.addSubview($0)
        }
        startRotationAnimation()
    }
    
    // MARK: - setupConstraints

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        splashLoadingImage.snp.makeConstraints { make in
            if UIScreen.main.bounds.size.height >= 812 {
                make.bottom.equalToSuperview().offset(-200)
            } else {
                make.bottom.equalToSuperview().offset(-100)
            }
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    private func startRotationAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            self.splashLoadingImage.transform = self.splashLoadingImage.transform.rotated(by: .pi)
        }, completion: nil)
    }
}

