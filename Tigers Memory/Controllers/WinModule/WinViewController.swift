//
//  WinViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class WinViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundWin.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var tigrButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.tigrButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(tigrButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, tigrButton].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tigrButton.snp.makeConstraints { make in
            if UIScreen.main.bounds.size.height >= 812 {
                make.bottom.equalToSuperview()
            } else {
                make.bottom.equalToSuperview()
                make.height.equalTo(450)
            }
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func tigrButtonTapped() {
        let controller = RewardsViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

