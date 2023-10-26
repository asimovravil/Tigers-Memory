//
//  ShopViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class ShopViewController: UIViewController {
    
    private var isButtonTapped = false
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.background.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "chowfun", size: 44)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var shopImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cardShop.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.selectButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var enoughLabel: UILabel = {
        let label = UILabel()
        label.text = "No enough coins"
        label.textAlignment = .center
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "chowfun", size: 44)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, titleLabel, shopImage, selectButton, enoughLabel].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(shopImage.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }
        shopImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        selectButton.snp.makeConstraints { make in
            make.top.equalTo(shopImage.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
        enoughLabel.snp.makeConstraints { make in
            make.top.equalTo(shopImage.snp.bottom).offset(120)
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
    
    // MARK: - Actions
    
    @objc private func selectButtonTapped() {
        if isButtonTapped {
            selectButton.isHidden = true
            enoughLabel.isHidden = false
        } else {
            shopImage.image = AppImage.cardSelectShop.uiImage
            selectButton.setImage(AppImage.buyButton.uiImage, for: .normal)
            enoughLabel.isHidden = true
        }
        
        isButtonTapped = !isButtonTapped
    }
}

