//
//  GameViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    
    let images = [
        AppImage.chairCell.uiImage,
        AppImage.coinCell.uiImage,
        AppImage.boxCell.uiImage,
        AppImage.frogCell.uiImage,
        AppImage.inyanCell.uiImage,
        AppImage.cloudCell.uiImage,
        AppImage.petrCell.uiImage,
        AppImage.flagCell.uiImage,
        AppImage.megaballsCell.uiImage,
        AppImage.orangeCell.uiImage,
        AppImage.fishCell.uiImage,
        AppImage.crazyCell.uiImage,
        AppImage.houseCell.uiImage,
        AppImage.catCell.uiImage,
        AppImage.ballsCell.uiImage
    ]
    
    var shuffledImages: [UIImage?] = []
    var selectedCells: [GameCollectionViewCell] = []
    var cellStatus: [Bool] = []
    var canOpenCells: Bool = true
    var numberOfPairsSolved: Int = 0
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundGame.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        shuffledImages = images.shuffled()
        cellStatus = Array(repeating: false, count: shuffledImages.count * 2)
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-150)
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
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shuffledImages.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameCollectionViewCell.reuseID,
            for: indexPath
        ) as? GameCollectionViewCell else {
            fatalError("Could not cast to GameCollectionViewCell")
        }

        let imageIndex = indexPath.item % shuffledImages.count
        if cellStatus[indexPath.item] {
            cell.cellImage.image = shuffledImages[imageIndex]
        } else {
            cell.cellImage.image = AppImage.cell.uiImage
        }

        cell.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        cell.addGestureRecognizer(tapGesture)
        cell.backgroundColor = .clear
        return cell
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
            if !canOpenCells {
                return
            }
            
            if let tappedCell = sender.view as? GameCollectionViewCell {
                if !tappedCell.isFlipped {
                    tappedCell.flip()
                    selectedCells.append(tappedCell)
                    
                    if selectedCells.count == 2 {
                        canOpenCells = false
                        checkForMatch()
                    }
                    
                    let indexPath = collectionView.indexPath(for: tappedCell)
                    if let item = indexPath?.item {
                        let imageIndex = item % shuffledImages.count
                        tappedCell.cellImage.image = shuffledImages[imageIndex]
                        cellStatus[item] = true
                    }
                }
            }
        }

    func checkForMatch() {
        if selectedCells.count == 2 {
            let cell1 = selectedCells[0]
            let cell2 = selectedCells[1]

            let imageIndex1 = collectionView.indexPath(for: cell1)!.item % shuffledImages.count
            let imageIndex2 = collectionView.indexPath(for: cell2)!.item % shuffledImages.count

            if shuffledImages[imageIndex1] == shuffledImages[imageIndex2] {
                selectedCells.removeAll()
                canOpenCells = true
                numberOfPairsSolved += 1

                checkForGameCompletion()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cell1.flip()
                    cell2.flip()
                    self.selectedCells.removeAll()
                    if let indexPath1 = self.collectionView.indexPath(for: cell1),
                       let indexPath2 = self.collectionView.indexPath(for: cell2) {
                        self.cellStatus[indexPath1.item] = false
                        self.cellStatus[indexPath2.item] = false
                        cell1.cellImage.image = AppImage.cell.uiImage
                        cell2.cellImage.image = AppImage.cell.uiImage
                        self.canOpenCells = true
                    }
                }
            }
        }
    }
    
    func checkForGameCompletion() {
        if numberOfPairsSolved == shuffledImages.count {
            if let navigationController = self.navigationController {
                let wheelViewController = WheelViewController()
                navigationController.pushViewController(wheelViewController, animated: true)
            }
        }
    }
}
