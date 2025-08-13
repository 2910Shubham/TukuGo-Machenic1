import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/screen/notification_screen.dart';
import 'package:tukugo/screen/otp-startRide.dart';
import 'package:tukugo/screen/payment/paymentPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnDuty = false;
  bool showJob = false;
  bool showDetailedDescription = false;
  bool showFairPriceEntry = false;
  bool showWaitingForCustomer = false;
  bool showCustomerRefusal = false;
  bool showReachPickupCard = false;
  bool showGuidedMapsCard = false;
  bool showGoToDropCard = false;
  bool showCompleteRideCard = false;
  bool showOnTheWayRideCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(34, 40, 34, 24),
            decoration: BoxDecoration(
                color: Color.fromRGBO(93, 32, 172, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location section
                Row(
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.pinkAccent,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Patna, Bihar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => Notifications()),
                          );
                        },
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Today's Returns section
                Row(
                  children: [
                    Container(
                      width: 290,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Today\'s Returns',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '₹0',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(253, 184, 36, 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.my_location_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: Stack(children: [
              // Show map if ON DUTY, else show normal content
              isOnDuty
                  ? FlutterMap(
                      options: MapOptions(
                        center: LatLng(28.6139, 77.2090),
                        zoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 80),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/Homecenter.png',
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Good morning!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Time to kick off the day and start Earning.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

              // ON/OFF DUTY Toggle
              Positioned(
                top: 20,
                left: MediaQuery.of(context).size.width / 3.2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOnDuty = !isOnDuty;
                            if (isOnDuty) {
                              // Show job alert when going on duty
                              showJob = true;
                            } else {
                              // Reset all states when going off duty
                              _resetAllStates();
                            }
                          });
                        },
                        child: Container(
                          width: 44,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isOnDuty
                                ? Color.fromRGBO(93, 32, 172, 0.6)
                                : Colors.grey.shade400,
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 200),
                            alignment: isOnDuty
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 20,
                              height: 40,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: isOnDuty
                                    ? Color.fromRGBO(93, 32, 172, 1)
                                    : Colors.grey.shade500,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isOnDuty ? "ON DUTY " : "OFF DUTY",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Job Alert Dialog (shows first when going on duty)
              if (showJob &&
                  !showDetailedDescription &&
                  !showFairPriceEntry &&
                  !showWaitingForCustomer &&
                  !showCustomerRefusal &&
                  !showReachPickupCard)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: JobAlertWidget(
                      onViewDetail: () {
                        setState(() {
                          showDetailedDescription = true;
                          showJob = false;
                        });
                      },
                    ),
                  ),
                ),

              // Detailed Description Dialog
              if (showDetailedDescription)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: DetailedDescriptionWidget(
                      onCancel: () {
                        setState(() {
                          showDetailedDescription = false;
                        });
                      },
                      onAskForFair: () {
                        setState(() {
                          showDetailedDescription = false;
                          showFairPriceEntry = true;
                        });
                      },
                    ),
                  ),
                ),

              // Fair Price Entry Dialog
              if (showFairPriceEntry)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: FairPriceEntryWidget(
                      onClose: () {
                        setState(() {
                          showFairPriceEntry = false;
                        });
                      },
                      onPriceSubmitted: (String price) {
                        setState(() {
                          showFairPriceEntry = false;
                          showWaitingForCustomer = true;
                        });
                        _showWaitingBottomSheet();
                      },
                    ),
                  ),
                ),

              // Customer Refusal Dialog
              if (showCustomerRefusal)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Customer refused on your fair',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Customer choice',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Amount',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '\$150',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Color(0xFF8E44AD),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showCustomerRefusal = false;
                                          showJob = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8E44AD),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showCustomerRefusal = false;
                                          showOnTheWayRideCard = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8E44AD),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      child: const Text(
                                        'Accept',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Reach Pickup Card
              if (showOnTheWayRideCard) _buildOnTheWayPickupCard(),
              if (showReachPickupCard) _buildReachPickupCard(),

              // Guided Maps Card
              if (showGuidedMapsCard) _buildGuidedMapsCard(),
            ]),
          )
        ],
      ),
    );
  }

  void _resetAllStates() {
    showDetailedDescription = false;
    showFairPriceEntry = false;
    showWaitingForCustomer = false;
    showCustomerRefusal = false;
    showReachPickupCard = false;
    showGuidedMapsCard = false;
    showGoToDropCard = false;
    showCompleteRideCard = false;
    showOnTheWayRideCard = false;
  }

  void _showWaitingBottomSheet() {
    showModalBottomSheet(
      isDismissible: true,
      context: Navigator.of(context, rootNavigator: true).context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF9B59B6), // Purple
                Color(0xFFE8D5F2), // Light purple/white
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          showWaitingForCustomer = false;
                          isOnDuty = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Waiting for customer\nacceptance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          showWaitingForCustomer = false;
                          showCustomerRefusal = true;
                          _showFoundBottomSheet();
                        });
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFoundBottomSheet() {
    showModalBottomSheet(
      isDismissible: false,
      context: Navigator.of(context, rootNavigator: true).context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8E44AD), // Purple
                Color(0xFFBB9BC5), // Lighter purple
              ],
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top indicator bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Location info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          showWaitingForCustomer = false;
                          showCustomerRefusal = true;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Bottom indicator line
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOnTheWayPickupCard() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.keyboard_arrow_up_rounded,
                      color: Colors.white, size: 28),
                  SizedBox(width: 4),
                  Text(
                    'Reach Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.black, size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Ulsoor Lake',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '32,ulsoor road,Halsuru.\nYepIla garden',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.phone, color: Colors.green, size: 28),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              showOnTheWayRideCard = false;
                              showReachPickupCard = true;
                              showGuidedMapsCard = true;
                            });
                          },
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                          label: const Text(
                            'On the Way',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(93, 32, 172, 1),
                            foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReachPickupCard() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.keyboard_arrow_up_rounded,
                      color: Colors.white, size: 28),
                  SizedBox(width: 4),
                  Text(
                    'Reach Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.black, size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Ulsoor Lake',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '32,ulsoor road,Halsuru.\nYepIla garden',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.phone, color: Colors.green, size: 28),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              showReachPickupCard = false;
                              showGuidedMapsCard = false;
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => PaymentScreen()),
                              );
                              showJob = true;
                            });
                          },
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                          label: const Text(
                            'Reached',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(93, 32, 172, 1),
                            foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildGuidedMapsCard() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: Colors.black, size: 32),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Ulsoor Lake',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '32,ulsoor road,Halsuru.\nYepIla garden',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Use TUKUGO guided maps',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showGuidedMapsCard = false;
                          showGoToDropCard = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black54,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('NO'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showGuidedMapsCard = false;
                          showGoToDropCard = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(93, 32, 172, 1),
                        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Maps'),
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

// Job Alert Widget
class JobAlertWidget extends StatelessWidget {
  final VoidCallback? onViewDetail;

  const JobAlertWidget({
    Key? key,
    this.onViewDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Job alert',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Short description',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          _buildDetailRow('Vehicle type', 'Car', Colors.orange),
          SizedBox(height: 8),
          _buildDetailRow('Vehicle model', 'Bmw S3', Colors.grey.shade600),
          SizedBox(height: 8),
          _buildDetailRow('Issue type', 'Engine failure', Colors.orange),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onViewDetail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6B46C1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'View detail',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: valueColor == Colors.orange
                ? Colors.orange
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color:
                  valueColor == Colors.orange ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Detailed Description Widget
class DetailedDescriptionWidget extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onAskForFair;

  const DetailedDescriptionWidget({
    Key? key,
    this.onCancel,
    this.onAskForFair,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFE8E3F3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildDetailRow('Vehicle type', 'Car', Colors.orange),
          SizedBox(height: 12),
          _buildDetailRow('Vehicle model', 'Bmw S3', Colors.grey.shade600),
          SizedBox(height: 12),
          _buildDetailRow('Issue type', 'Engine failure', Colors.orange),
          SizedBox(height: 16),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Sudden engine got stop, and started smoking outside. and after that car is not getting started',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                'assets/mechanicCar.png',
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAskForFair,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text('Ask for fair'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: valueColor == Colors.orange
                ? Colors.orange
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color:
                  valueColor == Colors.orange ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Fair Price Entry Widget
class FairPriceEntryWidget extends StatefulWidget {
  final Function(String)? onPriceSubmitted;
  final VoidCallback? onClose;

  const FairPriceEntryWidget({
    Key? key,
    this.onPriceSubmitted,
    this.onClose,
  }) : super(key: key);

  @override
  State<FairPriceEntryWidget> createState() => _FairPriceEntryWidgetState();
}

class _FairPriceEntryWidgetState extends State<FairPriceEntryWidget> {
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFE8E3F3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Enter your choice fair',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Enter amount to ask customer',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 4),
                Flexible(
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '250',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                String price = priceController.text.trim();
                if (price.isNotEmpty) {
                  if (widget.onPriceSubmitted != null) {
                    widget.onPriceSubmitted!(price);
                  }
                  if (widget.onClose != null) {
                    widget.onClose!();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6B46C1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Ask',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
