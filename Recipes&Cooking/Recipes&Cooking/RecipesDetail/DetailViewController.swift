
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
//        foodImageView.image = recipe?.image
//        foodNameLabel.text = recipe?.name
//        prepareTimeLabel.text = "\(String(describing: recipe!.timePrepare))"
//        servesLabel.text = "\(String(describing: recipe!.portions))"
//        ingredientsTextView.text = recipe?.ingredients
//        instructionsTextView.text = recipe?.instructions

    }
}
