/*
Предположительная структура таблиц
*/

CREATE TABLE #Products 
(
	Id INT NOT NULL,
	Name NVARCHAR(255) NOT NULL,
	PRIMARY KEY (Id)
)

CREATE TABLE #Categories 
(
	Id INT NOT NULL,
	Name NVARCHAR(255) NOT NULL,
	PRIMARY KEY (Id)
)

CREATE TABLE #ProductsCategories 
(
	ProductId INT NOT NULL FOREIGN KEY REFERENCES #Products (Id),
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES #Categories (Id),
	PRIMARY KEY (ProductId, CategoryId)
)

/*
Скрипт выборки пар «Имя продукта – Имя категории»
*/

SELECT CONCAT(product.Name, 
			  CASE
				  WHEN category.Name IS NOT NULL THEN N' - '
				  ELSE NULL
			  END, 
			  category.Name)
FROM #Products AS product
LEFT JOIN #ProductsCategories AS productCategories ON productCategories.ProductId = product.Id
LEFT JOIN #Categories As category ON category.Id = productCategories.CategoryId