# Tax Calculator
Tax calculator receives an input list of product with their prices and categories and outputs the receipt with taxes included.

## Environment
- OSx 10.9.5
- rbenv 0.4.0
- ruby 2.1.5

## Instalation
```sh
# after cloning it
$ bundle install
```

## Usage
```sh
$ ruby taxes.rb < INPUT1
$ ruby taxes.rb < INPUT2
$ ruby taxes.rb < INPUT3
```

## Testing
```sh
# for running the specs
$ rspec
# or, with guard
$ guard
```

## Description
The application reads lines of comma separated data. Each line contains the following:
```
Quantity, Name, Price, Categories
1, Book 1, 10, imported|book
```
Categories are pipe separated and optional you can use any combination of the following: `book, food, medical, imported`. If no category is specified, a default `general good` category will be assigned.

### Taxes rules
All products, except `food, book, medical`, will have an 10% tax. On top of this, any `imported` product will have an additional %5 tax.

### Round method
The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

### Input example
```
Quantity, Product, Price, Categories
1, imported bottle of perfume, 27.99, imported
1, bottle of perfume, 18.99
1, packet of headache pills, 9.75, medical
1, box of imported chocolates, 11.25, imported|food
```

### Output example
```
1, imported bottle of perfume, 32.19
1, bottle of perfume, 20.89
1, packet of headache pills, 9.75
1, box of imported chocolates, 11.85

Sales Taxes: 6.70
Total: 74.68
```

## Design
The `taxes.rb` file receives the input and create a new instace of `App`. The invokes the method `App#process`, passing the input as a parameter and printing the returned string.

The `App#process` method will create an instance of `Cart` and will add the products from the input. After this it creates a Tax Class instance (this might differ depending on each country laws), in our case is simply `Tax` and passes it as a parameter to the `Cart#apply_taxes` method.

The `Cart#apply_taxes` method will go through each cart item and will calculate the tax for each product with the method `Tax#calculate_tax`.

Any Tax Class should implement the methods `#get_rules` and `#calculate_tax(product)`

## TODO
- Optional first line in the input; It's kind of useless for now.
- If 2 products have the same name and price, it should update the existing one in the cart, not adding a new one