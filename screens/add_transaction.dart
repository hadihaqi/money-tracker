import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/providers/categories_provider.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/widgets/add_category.dart';

class AddTransaction extends ConsumerStatefulWidget {
  const AddTransaction({super.key});

  @override
  ConsumerState<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends ConsumerState<AddTransaction> {
  CategoryType _selectedType = CategoryType.expense;
  Category? _selectedCategory;
  DateTime? _selectedDate;

  final formatter = DateFormat.yMd();

  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSave() {
    final amount = double.tryParse(_amountController.text);
    final enteredTitle = _titleController.text.trim();
    final amountIsInvalid = amount == null || amount <= 0;
    if (enteredTitle.isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
        ),
      );
      return;
    }

    final currentUser = ref.read(currentUserProvider);

    final newTransaction = Transaction(
      userId: currentUser!.id,
      title: enteredTitle,
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory!,
    );

    ref.read(transactionsProvider.notifier).addTransaction(newTransaction);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    final categories = ref.watch(categoriesProvider);
    final currentUserCategories = categories.where(
      (c) => c.userId == currentUser!.id,
    );
    final currentUserSpecificTypeCategories = currentUserCategories.where(
      (c) => c.type == _selectedType,
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Transaction',
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Text(
              //   'Add Transaction',
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              // ),
              const SizedBox(height: 16),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),

                        prefixIcon: Icon(
                          FontAwesomeIcons.dollarSign,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<CategoryType>(
                          initialValue: _selectedType,
                          items: const [
                            DropdownMenuItem(
                              value: CategoryType.income,
                              child: Text("Income"),
                            ),
                            DropdownMenuItem(
                              value: CategoryType.expense,
                              child: Text("Expense"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value!;
                              _selectedCategory = null;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<Category>(
                          initialValue: _selectedCategory,
                          items: currentUserSpecificTypeCategories
                              .map(
                                (category) => DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.title),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 18,
                          ),
                        ),
                        onPressed: () async {
                          await showAddCategorySheet(
                            context,
                            ref,
                            _selectedType,
                          );
                        },
                        child: Text('Add Category'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(letterSpacing: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
