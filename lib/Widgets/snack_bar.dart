import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void showSnackBar(ScaffoldMessengerState messenger, String message, {bool isError = true}) {
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      duration: const Duration(seconds: 3),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E212D),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (isError ? Colors.redAccent : Colors.green).withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: (isError ? Colors.redAccent : Colors.green).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isError ? Colors.redAccent : Colors.green).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isError ? Iconsax.warning_2 : Iconsax.tick_circle,
                color: isError ? Colors.redAccent : Colors.green,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isError ? "Oops! Something went wrong" : "Success!",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
