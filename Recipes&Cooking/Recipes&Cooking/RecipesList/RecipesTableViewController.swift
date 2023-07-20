

import UIKit
import CoreData

class RecipesTableViewController: UIViewController {
    private var recipes = [Recipe]()
    private var emptyView = EmptyListView()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.selectionFollowsFocus = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: String(describing: RecipeCell.self))
        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        loadItems()
        checkEmptyList()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Receitas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createRecipe))
        print("open this file\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func createRecipe() {
        let formController = FormViewController()
        formController.delegate = self
        self.navigationController?.pushViewController(formController, animated: true)
    }

    private func checkEmptyList() {
        if recipes.isEmpty {
            view = emptyView
        } else {
            view = tableView
        }
    }

    func loadItems() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        do {
            recipes = try context.fetch(request)
        } catch {
            print("Error loading data from \(error)")
        }
        tableView.reloadData()
    }
}

extension RecipesTableViewController: FormViewControllerDelegate {
    func didSaveRecipe(recipe: Recipe) {
        recipes.append(recipe)
        tableView.reloadData()
//        checkEmptyList()
    }
}

    // MARK: - UITableViewDataSource

extension RecipesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self), for: indexPath) as? RecipeCell else { return UITableViewCell() }

        let recipe = recipes[indexPath.row]
        cell.prepareCell(recipe: recipe)
        return cell
    }
}

        // MARK: - UITableViewDelegate

    extension RecipesTableViewController: UITableViewDelegate {
        private func setupCellLayout(indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.selectionStyle = .gray

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                cell?.selectionStyle = .none
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            setupCellLayout(indexPath: indexPath)
            let recipes = recipes[indexPath.row]
            let recipeViewController = DetailViewController(recipe: recipes)

            recipeViewController.recipe = recipes
            self.navigationController?.show(recipeViewController, sender: recipes)
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            recipes.remove(at: indexPath.row)

            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let height = UIScreen.main.bounds.height
            return height * 0.15
        }
    }
