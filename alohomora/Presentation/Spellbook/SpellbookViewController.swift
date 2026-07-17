//
//  SpellbookViewController.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class SpellbookViewController: BaseViewController {
    let mainView: SpellbookView
    let viewModel: SpellbookViewModel
    let toggleFavorite: ToggleSpellFavoriteUseCaseProtocol

    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    init(
        viewModel: SpellbookViewModel,
        toggleFavorite: ToggleSpellFavoriteUseCaseProtocol
    ) {
        self.viewModel = viewModel
        self.toggleFavorite = toggleFavorite
        self.mainView = SpellbookView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.handle(state)
            }
        }

        setupLongPressGesture()
        viewModel.loadSpells()
    }
    
    private func handle(_ state: SpellbookViewState<[Spell]>) {
        switch state {
        case .idle:
            break
        case .loading:
            mainView.startLoading()
        case .loaded(let spells):
            mainView.stopLoading()
            UIView.transition(
                with: mainView.collectionView,
                duration: 0.4,
                options: [.transitionCrossDissolve, .curveEaseInOut],
                animations: {
                    self.mainView.setSpells(spells)
                },
                completion: nil
            )
        case .error(let error):
            mainView.stopLoading()
            //            contentView.showError(error.localizedDescription)
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
        
        if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
            if let spell = viewModel.spell(at: indexPath.item) {
                toggleFavorite.packInTrunk(spell.id)

                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
