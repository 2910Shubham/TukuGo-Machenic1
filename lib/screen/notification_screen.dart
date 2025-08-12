import 'package:flutter/material.dart';

// Data model for notifications
class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final bool highlight;
  final String section;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    this.highlight = false,
    required this.section,
  });
}

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  // Sample notification data
  static List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Payment confirm',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '15 min ago',
      highlight: true,
      section: 'Today',
    ),
    NotificationItem(
      title: 'Bonus Notice',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '25 min ago',
      section: 'Today',
    ),
    NotificationItem(
      title: 'Order Delivered',
      subtitle:
          'Your order #12345 has been successfully delivered to your address',
      time: '1 hour ago',
      highlight: false,
      section: 'Today',
    ),
    NotificationItem(
      title: 'Payment confirm',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '2 hours ago',
      highlight: true,
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Bonus Notice',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '1 day ago',
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Special Offer',
      subtitle:
          'Get 20% off on your next purchase. Limited time offer expires tomorrow',
      time: '1 day ago',
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Bonus Notice',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '1 day ago',
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Payment confirm',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '1 day ago',
      highlight: true,
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Account Update',
      subtitle: 'Your profile information has been successfully updated',
      time: '2 days ago',
      section: 'This Week',
    ),
    NotificationItem(
      title: 'New Feature',
      subtitle: 'Check out the new dark mode feature in your settings',
      time: '3 days ago',
      section: 'This Week',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Group notifications by section
    Map<String, List<NotificationItem>> groupedNotifications = {};
    for (var notification in notifications) {
      if (!groupedNotifications.containsKey(notification.section)) {
        groupedNotifications[notification.section] = [];
      }
      groupedNotifications[notification.section]!.add(notification);
    }

    // Create a flat list with section headers
    List<dynamic> displayItems = [];
    List<String> sectionOrder = ['Today', 'Yesterday', 'This Week'];

    for (String section in sectionOrder) {
      if (groupedNotifications.containsKey(section)) {
        displayItems.add(section); // Add section header
        displayItems.addAll(groupedNotifications[
            section]!); // Add notifications for this section
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(93, 32, 172, 1),
        elevation: 0,
        toolbarHeight: 0, // Hide default app bar
      ),
      body: Column(
        children: [
          // Custom top bar container
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Color.fromRGBO(93, 32, 172, 1),
            ),
            child: Stack(
              children: [
                // Back button
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                // Centered title
                const Center(
                  child: Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Body content
          Expanded(
            child: displayItems.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No notifications',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: displayItems.length,
                    itemBuilder: (context, index) {
                      final item = displayItems[index];

                      // If item is a String, it's a section header
                      if (item is String) {
                        return SectionTitle(title: item);
                      }

                      // Otherwise, it's a notification
                      final notification = item as NotificationItem;
                      return NotificationCard(
                        title: notification.title,
                        subtitle: notification.subtitle,
                        time: notification.time,
                        highlight: notification.highlight,
                        onTap: () {
                          // Handle notification tap
                            print('Tapped on: ${notification.title}');
                        },
                      );
                    },
                  ),
          ),
        ],
    ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF333333),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool highlight;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.highlight = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: highlight 
            ? const Color(0xFF6A1B9A).withOpacity(0.08)
            : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: highlight
              ? Border.all(
                  color: const Color(0xFF6A1B9A).withOpacity(0.2), 
                  width: 1
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: highlight 
                        ? const Color(0xFF6A1B9A)
                        : const Color(0xFF333333),
                    ),
                  ),
                ),
                if (highlight)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF6A1B9A),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
