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
    
    private lazy var rewardView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        if let randomRewardImage = rewards.randomElement() {
            rewardView.image = randomRewardImage
        }
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, rewardView].forEach() {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rewardView.snp.makeConstraints { make in
            if UIScreen.main.bounds.size.height >= 812 {
                make.bottom.equalToSuperview().offset(-200)
            } else {
                make.bottom.equalToSuperview().offset(-100)
            }
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func getButtonTapped() {
        let controller = WinViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
