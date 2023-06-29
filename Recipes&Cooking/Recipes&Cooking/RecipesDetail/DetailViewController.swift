
import UIKit
import PhotosUI

class DetailViewController: UIViewController {
//    @IBOutlet weak var foodImageView: UIImageView!
//    @IBOutlet weak var foodNameLabel: UILabel!
//    @IBOutlet weak var prepareTimeLabel: UILabel!
//    @IBOutlet weak var servesLabel: UILabel!
//    @IBOutlet weak var ingredientsTextView: UILabel!
//    @IBOutlet weak var instructionsTextView: UILabel!

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
//        foodImageView.image = recipe?.image
//        foodNameLabel.text = recipe?.name
//        prepareTimeLabel.text = "\(String(describing: recipe!.timePrepare))"
//        servesLabel.text = "\(String(describing: recipe!.portions))"
//        ingredientsTextView.text = recipe?.ingredients
//        instructionsTextView.text = recipe?.instructions
        
        if isNewRecipe {
            let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveRecipe))
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelRecipe))
            
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }

    @objc func cancelRecipe() {
        performSegue(withIdentifier: "CancelRecipe", sender: nil)
    }
    
    @objc func saveRecipe() {
        NotificationCenter.default.post(name: .RecipeSaved, object: recipe)
        self.navigationController?.popViewController(animated: true)
    }
}

extension Notification.Name {
    static let RecipeSaved = Notification.Name("SaveRecipe")
}

        

