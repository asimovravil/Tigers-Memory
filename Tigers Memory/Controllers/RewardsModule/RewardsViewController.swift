//
//  RewardsViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class RewardsViewController: UIViewController {
    
    let rewards = [
        AppImage.rewardChair.uiImage,
        AppImage.rewardCat.uiImage,
        AppImage.rewardFrog.uiImage
    ]
    
    var score: Int {
        get {
            return UserDefaults.standard.integer(forKey: "score")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "score")
            coinWalletLabel.text = "\(newValue)"
        }
    }
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundNewProgress.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var rewardButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(rewardButtonTapped), for: .touchUpInside)
        return button
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
        
        if let randomRewardImage = rewards.randomElement() {
            rewardButton.setImage(randomRewardImage, for: .normal)
        }
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, rewardButton].forEach() {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rewardButton.snp.makeConstraints { make in
            if UIScreen.main.bounds.size.height >= 812 {
                make.bottom.equalToSuperview().offset(-200)
            } else {
                make.bottom.equalToSuperview().offset(-100)
            }
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func rewardButtonTapped() {
        let controller = MainViewController()
        score += 70
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
