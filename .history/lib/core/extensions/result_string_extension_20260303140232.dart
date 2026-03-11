extension StringExtension on String? {
  // :: Get first and second name from full name
  String get firstNameSecondName {
    if (this == null || this!.isEmpty) return '---';
    
    final parts = this!.trim().split(' ');
    
    if (parts.length >= 2) {
      return '${parts[0]} ${parts[1]}';
    } else if (parts.length == 1) {
      return parts[0];
    } else {
      return '---';
    }
  }
  
  // :: Get first letter for avatar
  String get initials {
    if (this == null || this!.isEmpty) return '';
    
    final parts = this!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}