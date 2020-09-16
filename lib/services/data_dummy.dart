import 'package:test_app/models/any_billing_child_item.dart';
import 'package:test_app/models/any_menu_item.dart';
import 'package:test_app/services/user.dart';

List<User> userDummyList = [
  User(name: "User1", phone: "12345678910", password: "123"),
  User(name: "User2", phone: "1111122222", password: "12")
];

List<AnyBillingChildItem> dummyBilling = [
  AnyBillingChildItem(
    id: 'ID-213',
    menuId: '1',
    name: 'Pizza SS',
    price: 500,
    toppings: 'Extra Cheese',
    notes: 'No Vegetables',
    amount: 1,
  ),
];

List<AnyMenuItem> dummyMenu = [
  AnyMenuItem(
    id: '1',
    name: 'Pizza SS',
    price: '500',
    category: 'food',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '2',
    name: 'Cheems Pizza',
    price: '100',
    category: 'food',
    description: 'Buy cheems, be hamppy.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: true,
  ),
  AnyMenuItem(
    id: '3',
    name: 'Pizza Again',
    price: '200',
    category: 'food',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '1',
    name: 'Pizza SS',
    price: '500',
    category: 'food',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '2',
    name: 'Cheems Pizza',
    price: '100',
    category: 'food',
    description: 'Buy cheems, be hamppy.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: true,
  ),
  AnyMenuItem(
    id: '1',
    name: 'Pizza SS',
    price: '500',
    category: 'food',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '2',
    name: 'Cheems Pizza',
    price: '100',
    category: 'food',
    description: 'Buy cheems, be hamppy.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: true,
  ),
  AnyMenuItem(
    id: '3',
    name: 'Pizza Again',
    price: '200',
    category: 'food',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '1',
    name: 'Pizza SS',
    price: '500',
    category: 'food',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '4',
    name: 'Drink 1',
    price: '100',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '5',
    name: 'Water',
    price: '80',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '6',
    name: 'Tap Water',
    price: '50',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '4',
    name: 'Drink 1',
    price: '100',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '5',
    name: 'Water',
    price: '80',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '6',
    name: 'Tap Water',
    price: '50',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '5',
    name: 'Water',
    price: '80',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '6',
    name: 'Tap Water',
    price: '50',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
  AnyMenuItem(
    id: '4',
    name: 'Drink 1',
    price: '100',
    category: 'drink',
    description: 'Basically a delicious thing to try so buy it.',
    imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
    soldOut: false,
  ),
];

List<String> foodCategories = [
  'All',
  'Packages',
  'Food',
  'Drink',
  'Beverages',
  'Snacks',
  'Holiday Special'
];