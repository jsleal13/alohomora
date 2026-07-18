//
//  TrunkViewController.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class TrunkViewController: BaseViewController {
    let mainView: TrunkView
    let viewModel: TrunkViewModel

    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    init(viewModel: TrunkViewModel) {
        self.viewModel = viewModel
        self.mainView = TrunkView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        viewModel.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.handle(state)
            }
        }

        setupLongPressGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFavorites()
    }
    
    private func handle(_ state: TrunkViewState) {
        switch state {
        case .idle:
            break
        case .loading:
            mainView.startLoading()
        case .loaded:
            mainView.stopLoading()
            animateReloadData()
            checkEmptyState()
        case .error(let error):
            mainView.stopLoading()
            //            contentView.showError(error.localizedDescription)
        }
    }
    
    private func animateReloadData() {
        UIView.transition(
            with: mainView.collectionView,
            duration: 0.4,
            options: [.transitionCrossDissolve, .curveEaseInOut],
            animations: {
                self.mainView.collectionView.reloadData()
            },
            completion: nil
        )
    }
    
    private func checkEmptyState() {
        if viewModel.items.isEmpty {
            
        }
    }
    
    private func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.minimumPressDuration = 0.5

        mainView.collectionView.addGestureRecognizer(longPress)
    }

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let collectionView = mainView.collectionView
        let touchPoint = gesture.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: touchPoint),
           let cell = collectionView.cellForItem(at: indexPath) {
            
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()

            viewModel.packInTrunk(at: indexPath.item)
            
            cell.animateFavoriteFeedback(isAdding: false) { [weak self] in
                self?.viewModel.loadFavorites()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TrunkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel.item(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        switch item {
        case .character(let character):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrunkCharacterCell.identifier,
                for: indexPath
            ) as! TrunkCharacterCell
            cell.configure(with: character)
            return cell
            
        case .spell(let spell):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrunkSpellCell.identifier,
                for: indexPath
            ) as! TrunkSpellCell
            cell.configure(with: spell)
            return cell
        }
    }
}
