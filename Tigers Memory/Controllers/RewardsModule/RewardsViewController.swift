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
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
