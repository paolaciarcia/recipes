

import UIKit

class RecipesTableViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private var recipe = [Recipe]()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(RecipeCell.self, forCellReuseIdentifier: String(describing: RecipeCell.self))
        tableView.backgroundColor = .white
        return tableView
    }()

    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateRecipeList(notification:)), name: .RecipeSaved, object: nil)
        tableView.reloadData()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func updateRecipeList(notification: Notification) {
        guard let recipes = notification.object as? Recipe else {
            return
        }
        recipe.append(recipes)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipe" {

            guard let recipeViewController = segue.destination as?
                    DetailViewController,
                  let recipe = sender as? Recipe else {
                return
            }

            recipeViewController.recipe = recipe
        }

        if segue.identifier == "AddRecipeSegue" {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        }
    }
}
    
    // MARK: - Table view data source

extension RecipesTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self), for: indexPath) as? RecipeCell else { fatalError("Could not create RecipeCell") }

        cell.prepareCell(recipe: recipe[indexPath.row])
        return cell
    }
}

        // MARK: - Table view Delegate

    extension RecipesTableViewController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let recipes = recipe[indexPath.row]
            performSegue(withIdentifier: "ShowRecipe", sender: recipes)
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            recipe.remove(at: indexPath.row)

            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }
