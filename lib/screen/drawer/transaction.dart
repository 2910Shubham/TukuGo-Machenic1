import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(93, 32, 172, 1),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              context.push('/notifications');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Color.fromRGBO(93, 32, 172, 1)),
            child: Text('Transactions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                )),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 8,
              itemBuilder: (context, index) {
                bool isDebit = index % 2 == 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.tealAccent),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: isDebit
                              ? Colors.red.shade100
                              : Colors.green.shade100,
                          child: Icon(
                            isDebit ? Icons.remove : Icons.check,
                            color: isDebit ? Colors.red : Colors.green,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isDebit ? 'Sanjana' : 'Priyam',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              'Today at 09:20 am',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          isDebit ? '-₹570.00' : '₹570.00',
                          style: TextStyle(
                            color: isDebit ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   selectedIndex: selectedIndex,
      //   onItemSelected: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //   },
      // ),
    );
  }
}

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemSelected;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.black87,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
  //             blurRadius: 10,
  //             offset: Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           _buildNavItem(Icons.home, 'Home', 0),
  //           _buildNavItem(Icons.currency_rupee, 'Wallet', 1),
  //           _buildNavItem(Icons.settings, 'Settings', 2),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildNavItem(IconData icon, String label, int index) {
  //   bool isSelected = selectedIndex == index;

  //   return GestureDetector(
  //     onTap: () => onItemSelected(index),
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 200),
        // padding: EdgeInsets.symmetric(
        //   horizontal: isSelected ? 16 : 12,
        //   vertical: 8,
        // ),
        // decoration: BoxDecoration(
        //   color: isSelected
        //       ? Colors.white.withOpacity(0.2)
        //       : Colors.transparent,
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // child: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Icon(icon, color: Colors.white, size: 20),
        //     if (isSelected) ...[
        //       const SizedBox(width: 8),
        //       Text(
        //         label,
        //         style: const TextStyle(
        //           color: Colors.white,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w500,
        //         ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
