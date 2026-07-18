//
//  HomeViewController.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

final class HomeViewController: BaseViewController {
    let mainView: HomeView
    private let viewModel: HomeViewModel

    override func loadView() {
        super.loadView()
        view = mainView
    }

    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        self.mainView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.housesView.delegate = self
        mainView.charactersView.mainCarroussel.dataSource = self
        mainView.charactersView.mainCarroussel.delegate = self

        viewModel.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.handle(state)
            }
        }

        setupLongPressGesture()
        viewModel.loadCharacters()
    }

    private func handle(_ state: ViewState) {
        switch state {
        case .idle:
            break
        case .loading:
            mainView.charactersView.startLoading()
        case .loaded:
            mainView.charactersView.stopLoading()
            UIView.transition(
                with: mainView.charactersView.mainCarroussel,
                duration: 0.4,
                options: [.transitionCrossDissolve, .curveEaseInOut],
                animations: {
                    self.mainView.charactersView.mainCarroussel.reloadData()
                },
                completion: nil
            )
        case .error(let error):
            mainView.charactersView.stopLoading()
            //show error
        }
    }

    private func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.minimumPressDuration = 0.5

        mainView.charactersView.mainCarroussel.addGestureRecognizer(longPress)
    }

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let collectionView = mainView.charactersView.mainCarroussel
        let touchPoint = gesture.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
            if let character = viewModel.character(at: indexPath.item), let cell = collectionView.cellForItem(at: indexPath) {

                viewModel.packInTrunk(id: character.id)
                let isAdding = viewModel.checkIfIsPacked(id: character.id)
                cell.animateFavoriteFeedback(isAdding: isAdding)

                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        if let character = viewModel.character(at: indexPath.item) {
            cell.setUp(with: character)
        }
        return cell
    }
}

extension HomeViewController: HousesViewDelegate {
    func didSelectHouse(_ house: House) {
        viewModel.loadCharactersByHouse(house: house)
    }
}
