class User {
  final int id;
  final String email;
  final DateTime createdAt;

  const User({required this.id, required this.email, required this.createdAt});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, email, createdAt);

  @override
  String toString() {
    return 'User(id: $id, email: $email, createdAt: $createdAt)';
  }
}
