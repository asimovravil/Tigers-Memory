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
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Level"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "chowfun", size: 44)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var coinWalletImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.coinSolo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 42).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        return imageView
    }()
    
    public lazy var coinWalletStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coinWalletImage, UIView(), coinWalletLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.backgroundColor = AppColor.radialCustom.uiColor
        stackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 32)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var coinWalletLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "chowfun", size: 24)
        label.textColor = AppColor.blackCustom.uiColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showWinViewController), userInfo: nil, repeats: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let score = UserDefaults.standard.integer(forKey: "score")
        coinWalletLabel.text = "\(score)"
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, fortunaImage, levelLabel, coinWalletStackView].forEach() {
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
        levelLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: AppImage.backNavigationButton.uiImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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

