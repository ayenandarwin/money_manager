import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/data/model/transaction.dart';
import 'package:money_manager_app/provider/common.dart';
import 'package:money_manager_app/provider/transaction.dart';
import 'package:money_manager_app/utils/color.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  late final TextEditingController _noteController;

  // Map of categories for Expense, Income, Transfer
  final Map<TransactionType, List<Map<String, dynamic>>> _categories = {
    TransactionType.expense: [
      {'name': 'Shopping', 'icon': Icons.shopping_cart},
      {'name': 'Food', 'icon': Icons.fastfood},
      {'name': 'Phone', 'icon': Icons.phone_android},
      {'name': 'Entertainment', 'icon': Icons.movie},
      {'name': 'Education', 'icon': Icons.school},
      {'name': 'Beauty', 'icon': Icons.spa},
      {'name': 'Sports', 'icon': Icons.sports_soccer},
      {'name': 'Social', 'icon': Icons.people},
      {'name': 'Transport', 'icon': Icons.directions_bus},
      {'name': 'Clothing', 'icon': Icons.checkroom},
      {'name': 'Car', 'icon': Icons.directions_car},
      {'name': 'Alcohol', 'icon': Icons.local_bar},
      {'name': 'Cigarettes', 'icon': Icons.smoking_rooms},
      {'name': 'Electronics', 'icon': Icons.devices},
      {'name': 'Travel', 'icon': Icons.flight},
      {'name': 'Health', 'icon': Icons.medical_services},
      {'name': 'Pets', 'icon': Icons.pets},
      {'name': 'Repairs', 'icon': Icons.build},
      {'name': 'Housing', 'icon': Icons.home_work},
      {'name': 'Home', 'icon': Icons.home},
      {'name': 'Gifts', 'icon': Icons.card_giftcard},
      {'name': 'Donations', 'icon': Icons.favorite},
      {'name': 'Lottery', 'icon': Icons.casino},
      {'name': 'Snacks', 'icon': Icons.cookie},
      {'name': 'Kids', 'icon': Icons.child_care},
      {
        'name': 'Vegetables',
        'icon': Icons.local_florist,
      }, // Using flower for vegetables, could be more specific
      {'name': 'Fruits', 'icon': Icons.apple},
      {'name': 'Others', 'icon': Icons.more_horiz},
    ],
    TransactionType.income: [
      {'name': 'Salary', 'icon': Icons.account_balance_wallet},
      {'name': 'Investments', 'icon': Icons.trending_up},
      {'name': 'Part-Time', 'icon': Icons.work},
      {'name': 'Bonus', 'icon': Icons.money},
      {'name': 'Game', 'icon': Icons.gamepad},
      {'name': 'Others', 'icon': Icons.more_horiz},
    ],
    TransactionType.transfer: [
      {'name': 'Bank', 'icon': Icons.account_balance},
      {'name': 'Cash', 'icon': Icons.payments},
      {'name': 'Wallet', 'icon': Icons.wallet},
      {'name': 'Others', 'icon': Icons.more_horiz},
    ],
  };

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(
      text: ref.read(transactionNoteProvider),
    );

    _noteController.addListener(() {
      ref.read(transactionNoteProvider.notifier).state = _noteController.text;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addTransactionTypeProvider.notifier).state =
          TransactionType.expense;
      ref.read(currentAmountInputProvider.notifier).state = '0';
      ref.read(selectedCategoryProvider.notifier).state = null;
      ref.read(transactionNoteProvider.notifier).state = '';
      ref.read(transactionDateProvider.notifier).state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // Handles calculator button presses
  void _onCalculatorButtonPressed(String buttonText) {
    final currentAmount = ref.read(currentAmountInputProvider);
    String newAmount = currentAmount;

    // Use setState only for local UI updates if needed, otherwise rely on Riverpod for state changes
    // For amount input, directly update Riverpod state.
    if (buttonText == '✓') {
      // Confirm transaction
      _addTransaction();
      return;
    } else if (buttonText == 'C') {
      // Clear button (if added)
      newAmount = '0';
    } else if (buttonText == '⌫') {
      // Backspace
      if (newAmount.length > 1) {
        newAmount = newAmount.substring(0, newAmount.length - 1);
      } else {
        newAmount = '0';
      }
    } else if (buttonText == '.') {
      if (!newAmount.contains('.')) {
        newAmount += '.';
      }
    } else if (buttonText == '+') {
      // Simple handling for + and - for display purposes.
      // For actual calculation, you'd parse the expression.
      // Here, just append or replace if last char is an operator.
      if (newAmount.isNotEmpty &&
          (newAmount.endsWith('+') || newAmount.endsWith('-'))) {
        newAmount = newAmount.substring(0, newAmount.length - 1) + buttonText;
      } else {
        newAmount += buttonText;
      }
    } else if (buttonText == '-') {
      if (newAmount.isNotEmpty &&
          (newAmount.endsWith('+') || newAmount.endsWith('-'))) {
        newAmount = newAmount.substring(0, newAmount.length - 1) + buttonText;
      } else {
        newAmount += buttonText;
      }
    } else if (buttonText == 'Today') {
      _selectDate(context);
      return; // Don't append 'Today' to amount
    } else {
      // Number input
      if (newAmount == '0' && buttonText != '.') {
        newAmount = buttonText;
      } else {
        newAmount += buttonText;
      }
    }

    ref.read(currentAmountInputProvider.notifier).state = newAmount;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(transactionDateProvider),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: primary, // Header background color
              onPrimary: Colors.black, // Header text color
              surface: const Color(0xFF2C2C2C), // Calendar background color
              onSurface: Colors.white, // Calendar text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primary, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      ref.read(transactionDateProvider.notifier).state = picked;
    }
  }

  void _addTransaction() {
    final currentType = ref.read(addTransactionTypeProvider);
    final currentAmountStr = ref.read(currentAmountInputProvider);
    final selectedCategory = ref.read(selectedCategoryProvider);
    final note = ref.read(transactionNoteProvider);
    final date = ref.read(transactionDateProvider);

    if (selectedCategory == null ||
        currentAmountStr == '0' ||
        currentAmountStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category and enter an amount.'),
        ),
      );
      return;
    }

    try {
      // Basic evaluation for expressions like "100+50" or "200-30"
      double amountValue;
      if (currentAmountStr.contains('+')) {
        final parts = currentAmountStr.split('+');
        amountValue = double.parse(parts[0]) + double.parse(parts[1]);
      } else if (currentAmountStr.contains('-')) {
        final parts = currentAmountStr.split('-');
        amountValue = double.parse(parts[0]) - double.parse(parts[1]);
      } else {
        amountValue = double.parse(currentAmountStr);
      }

      final newTransaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        category: selectedCategory,
        amount: amountValue.abs(), // Ensure amount is positive
        type: currentType,
        date: date,
        description: note.isEmpty ? null : note,
      );

      ref.read(transactionsProvider.notifier).addIncomeTransation(newTransaction,ref);
      Navigator.of(context).pop(); // Go back to previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${currentType.toString().split('.').last} added successfully!',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid amount or calculation error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentType = ref.watch(addTransactionTypeProvider);
    final currentAmount = ref.watch(currentAmountInputProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    // final note = ref.watch(transactionNoteProvider);
    final transactionDate = ref.watch(transactionDateProvider);
    // Removed controller = ref.watch(noteControllerProvider); as it's not used directly here.
    // _noteController is initialized in initState and is tied to transactionNoteProvider.

    final List<Map<String, dynamic>> categoriesForType =
        _categories[currentType] ?? [];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('Add'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.currency_exchange), // Currency symbol icon
            onPressed: () {
              // Handle currency change - placeholder
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change currency feature')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Expense/Income/Transfer Tabs
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children:
                      TransactionType.values.map((type) {
                        bool isSelected = currentType == type;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(addTransactionTypeProvider.notifier)
                                  .state = type;
                              ref
                                  .read(selectedCategoryProvider.notifier)
                                  .state = null; // Reset category on tab change
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? primary : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                type.toString().split('.').last.toUpperCase(),
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Category Grid
            SizedBox(
              // <--- Wrap GridView.builder with SizedBox and provide a height constraint
              height:
                  MediaQuery.of(context).size.height *
                  0.35, // Adjust this value as needed
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      0.8, // Adjust aspect ratio for better spacing
                ),
                itemCount: categoriesForType.length,
                itemBuilder: (context, index) {
                  final category = categoriesForType[index];
                  final isSelected = selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state =
                          category['name'] as String;
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? primary
                                    : Theme.of(context).cardTheme.color,
                            shape: BoxShape.circle,
                            border:
                                isSelected
                                    ? Border.all(color: primary, width: 2)
                                    : null,
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: isSelected ? Colors.white : Colors.black54,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category['name'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? primary : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Amount Display and Note Input
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      // Format the displayed amount. Handle simple expressions.
                      _formatAmountDisplay(currentAmount),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText:
                          'Note: ${DateFormat('MMM dd').format(transactionDate)}',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.grey),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Camera functionality'),
                            ),
                          );
                        },
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),

            // Calculator Keypad
            _buildCalculatorKeypad(context),
          ],
        ),
      ),
    );
  }

  // Helper to format amount display, handling potential operators
  String _formatAmountDisplay(String amount) {
    if (amount.isEmpty) return '0';
    if (amount.endsWith('+') || amount.endsWith('-') || amount.endsWith('.')) {
      return amount; // Don't format if it ends with an operator or decimal
    }
    try {
      // Simple evaluation for display if it's a simple expression
      if (amount.contains('+')) {
        final parts = amount.split('+');
        return NumberFormat.currency(
          symbol: '',
          decimalDigits: 0,
        ).format(double.parse(parts[0]) + double.parse(parts[1]));
      } else if (amount.contains('-')) {
        final parts = amount.split('-');
        return NumberFormat.currency(
          symbol: '',
          decimalDigits: 0,
        ).format(double.parse(parts[0]) - double.parse(parts[1]));
      }
      return NumberFormat.currency(
        symbol: '',
        decimalDigits: 0,
      ).format(double.parse(amount));
    } catch (e) {
      return amount; // Return as is if parsing fails
    }
  }

  Widget _buildCalculatorKeypad(BuildContext context) {
    final List<String> buttons = [
      '7', '8', '9', 'Today', '+',
      '4', '5', '6', '-', '⌫',
      '1', '2', '3', '.', '✓',
      '0', // '0' is alone in the last row
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Theme.of(context).scaffoldBackgroundColor, // Match background
      child: GridView.builder(
        shrinkWrap: true, // Take only necessary space
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 5 columns as per image
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.5, // Adjust for rectangular buttons
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final buttonText = buttons[index];
          Color buttonColor =
              Theme.of(context).cardTheme.color!; // Default dark color
          Color textColor = Colors.black;
          double fontSize = 24;

          if (buttonText == '✓') {
            buttonColor = primary;
            textColor = Colors.white;
          } else if (buttonText == 'Today' ||
              buttonText == '+' ||
              buttonText == '-' ||
              buttonText == '⌫') {
            buttonColor = Theme.of(context).cardTheme.color!;
            fontSize = 20;
          } else if (buttonText == '.') {
            fontSize = 30; // Larger for dot
          }

          return GestureDetector(
            onTap: () => _onCalculatorButtonPressed(buttonText),
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:money_manager_app/data/model/expense/expense.dart';
// import 'package:money_manager_app/data/model/income/income.dart';
// import 'package:money_manager_app/data/model/transactions.dart';
// import 'package:money_manager_app/provider/common.dart';
// import 'package:money_manager_app/provider/service_provider.dart';
// import 'package:money_manager_app/provider/transaction.dart';

// // import your models

// // ---------------- Providers for API calls ---------------- //

// final addIncomeProvider = FutureProvider.family<void, Income>((
//   ref,
//   income,
// ) async {
//   final repo = ref.read(incomeRepositoryProvider);
//   await repo.postIncomeData(income);
// });

// final addExpenseProvider = FutureProvider.family<void, Expense>((
//   ref,
//   expense,
// ) async {
//   final repo = ref.read(expenseRepositoryProvider);
//   await repo.postExpenseData(expense);
// });

// // ---------------- AddTransactionScreen ---------------- //

// class AddTransactionScreen extends ConsumerWidget {
//   const AddTransactionScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentType = ref.watch(addTransactionTypeProvider);
//     final amountInput = ref.watch(currentAmountInputProvider);
//     final selectedCategory = ref.watch(selectedCategoryProvider);
//     final note = ref.watch(transactionNoteProvider);
//     final date = ref.watch(transactionDateProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Transaction'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: () async {
//               await _addTransaction(
//                 context,
//                 ref,
//                 currentType: currentType,
//                 currentAmountStr: amountInput,
//                 selectedCategory: selectedCategory,
//                 note: note,
//                 date: date,
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ---- Transaction Type (Income / Expense) ----
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ChoiceChip(
//                     label: const Text("Income"),
//                     selected: currentType == TransactionType.income,
//                     onSelected: (_) {
//                       ref.read(addTransactionTypeProvider.notifier).state =
//                           TransactionType.income;
//                     },
//                   ),
//                   const SizedBox(width: 12),
//                   ChoiceChip(
//                     label: const Text("Expense"),
//                     selected: currentType == TransactionType.expense,
//                     onSelected: (_) {
//                       ref.read(addTransactionTypeProvider.notifier).state =
//                           TransactionType.expense;
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // ---- Amount Input ----
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: "Amount",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (val) {
//                   ref.read(currentAmountInputProvider.notifier).state = val;
//                 },
//               ),
//               const SizedBox(height: 20),

//               // ---- Category Selector ----
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   labelText: "Category",
//                   border: OutlineInputBorder(),
//                 ),
//                 value: selectedCategory,
//                 items:
//                     ['Food', 'Transport', 'Shopping', 'Salary', 'Other'].map((
//                       cat,
//                     ) {
//                       return DropdownMenuItem(value: cat, child: Text(cat));
//                     }).toList(),
//                 onChanged: (val) {
//                   ref.read(selectedCategoryProvider.notifier).state = val;
//                 },
//               ),
//               const SizedBox(height: 20),

//               // ---- Note ----
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: "Note (optional)",
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (val) {
//                   ref.read(transactionNoteProvider.notifier).state = val;
//                 },
//               ),
//               const SizedBox(height: 20),

//               // ---- Date Picker ----
//               Row(
//                 children: [
//                   const Icon(Icons.calendar_today),
//                   const SizedBox(width: 10),
//                   Text(
//                     "${date.toLocal()}".split(' ')[0],
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const Spacer(),
//                   TextButton(
//                     onPressed: () async {
//                       final pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: date,
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         ref.read(transactionDateProvider.notifier).state =
//                             pickedDate;
//                       }
//                     },
//                     child: const Text("Change"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _addTransaction(
//     BuildContext context,
//     WidgetRef ref, {
//     required TransactionType currentType,
//     required String currentAmountStr,
//     required String? selectedCategory,
//     required String note,
//     required DateTime date,
//   }) async {
//     if (selectedCategory == null ||
//         currentAmountStr.isEmpty ||
//         currentAmountStr == '0') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a category and enter an amount.'),
//         ),
//       );
//       return;
//     }

//     try {
//       // Handle + / - operations
//       double amountValue;
//       if (currentAmountStr.contains('+')) {
//         final parts = currentAmountStr.split('+');
//         amountValue = double.parse(parts[0]) + double.parse(parts[1]);
//       } else if (currentAmountStr.contains('-')) {
//         final parts = currentAmountStr.split('-');
//         amountValue = double.parse(parts[0]) - double.parse(parts[1]);
//       } else {
//         amountValue = double.parse(currentAmountStr);
//       }

//       // Call backend
//       if (currentType == TransactionType.income) {
//         final income = Income(
//           id: 0,
//           amount: amountValue,
//           userId: 1,
//           providerId: 1,
//           description: note,
//           createdAt: date,
//           updatedAt: date,
//         );

//         await ref.read(addIncomeProvider(income).future);
//       } else {
//         final expense = Expense(
//           id: 0,
//           amount: amountValue,
//           userId: 1,
//           providerId: 1,
//           description: note,
//           createdAt: date,
//           updatedAt: date,
//         );

//         await ref.read(addExpenseProvider(expense).future);
//       }

//       // Local optimistic update
//       final newTransaction = Transaction(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         category: selectedCategory,
//         amount: amountValue.abs(),
//         type: currentType,
//         date: date,
//         description: note.isEmpty ? null : note,
//       );
//       ref.read(transactionsProvider.notifier).addTransaction(newTransaction);

//       Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('${currentType.name} added successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error while saving: $e')));
//     }
//   }
// }
