import 'dart:io';

class Expense {
  String description;
  double amount;
  DateTime date;

  Expense(this.description, this.amount, this.date);

  @override
  String toString() {
    return '$description - \$${amount.toStringAsFixed(2)} on ${date.toLocal()}';
  }
}

class ExpenseManager {
  final List<Expense> _expenses = [];

  void addExpense(String description, double amount) {
    _expenses.add(Expense(description, amount, DateTime.now()));
    print('✅ Expense added!');
  }

  void viewExpenses() {
    if (_expenses.isEmpty) {
      print('📭 No expenses recorded.');
      return;
    }
    print('\n📝 Your Expenses:');
    for (var i = 0; i < _expenses.length; i++) {
      print('${i + 1}. ${_expenses[i]}');
    }
  }

  void deleteExpense(int index) {
    if (index < 0 || index >= _expenses.length) {
      print('⚠️ Invalid index.');
      return;
    }
    print('🗑️ Deleted: ${_expenses[index]}');
    _expenses.removeAt(index);
  }

  void viewTotal() {
    double total = _expenses.fold(0, (sum, item) => sum + item.amount);
    print('\n💵 Total spent: \$${total.toStringAsFixed(2)}');
  }
}

void main() {
  final manager = ExpenseManager();

  while (true) {
    print('\n=== Expense Tracker ===');
    print('1. Add Expense');
    print('2. View Expenses');
    print('3. Delete Expense');
    print('4. View Total');
    print('5. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter description: ');
        String? description = stdin.readLineSync();

        stdout.write('Enter amount: ');
        String? amountInput = stdin.readLineSync();
        double? amount = double.tryParse(amountInput ?? '');

        if (description != null && amount != null) {
          manager.addExpense(description, amount);
        } else {
          print('⚠️ Invalid input.');
        }
        break;

      case '2':
        manager.viewExpenses();
        break;

      case '3':
        manager.viewExpenses();
        stdout.write('Enter expense number to delete: ');
        String? input = stdin.readLineSync();
        int? index = int.tryParse(input ?? '');
        if (index != null) {
          manager.deleteExpense(index - 1);
        } else {
          print('⚠️ Invalid input.');
        }
        break;

      case '4':
        manager.viewTotal();
        break;

      case '5':
        print('👋 Goodbye!');
        exit(0);

      default:
        print('⚠️ Invalid choice. Try again.');
    }
  }
}

