
import UIKit
import PhotosUI

class DetailViewController: UIViewController {
    var recipe: Recipe
    var isNewRecipe = false
    private let contentView: RecipeDetailView

    init(recipe: Recipe,
         contentView: RecipeDetailView = RecipeDetailView()) {
        self.recipe = recipe
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = contentView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.show(viewModel: recipe)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
