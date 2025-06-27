import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books & documents',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const BooksHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BooksHomePage extends StatefulWidget {
  const BooksHomePage({super.key});

  @override
  State<BooksHomePage> createState() => _BooksHomePageState();
}

class _BooksHomePageState extends State<BooksHomePage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final List<Book> _allBooks = [
    Book(
      image: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      title: 'The Call of the Wild',
      author: 'Jack London',
      fileInfo: 'EPUB, 196 KB',
      isStarred: true,
      isRecent: false,
      isCompleted: false,
      isOnShelf: false,
    ),
    Book(
      image: 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
      title: 'Anna Karenina',
      author: 'Leo Tolstoy',
      fileInfo: 'PDF, 1.3 MB',
      isStarred: true,
      isRecent: true,
      isCompleted: true,
      isOnShelf: true,
    ),
    Book(
      image: 'https://covers.openlibrary.org/b/id/8228691-L.jpg',
      title: 'The Hound of the Baskervilles',
      author: 'Arthur Conan Doyle',
      fileInfo: 'PDF, 750 KB',
      isStarred: false,
      isRecent: true,
      isCompleted: false,
      isOnShelf: true,
    ),
    Book(
      image: 'https://covers.openlibrary.org/b/id/11153223-L.jpg',
      title: 'Relativity - The Special Theory',
      author: 'Albert Einstein',
      fileInfo: 'PDF, 1.3 MB',
      isStarred: false,
      isRecent: false,
      isCompleted: false,
      isOnShelf: false,
    ),
    Book(
      image: 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
      title: 'War and Peace',
      author: 'Leo Tolstoy',
      fileInfo: 'PDF, 2.1 MB',
      isStarred: true,
      isRecent: false,
      isCompleted: true,
      isOnShelf: true,
    ),
    Book(
      image: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      title: 'White Fang',
      author: 'Jack London',
      fileInfo: 'EPUB, 245 KB',
      isStarred: false,
      isRecent: true,
      isCompleted: false,
      isOnShelf: false,
    ),
  ];

  List<Book> get _filteredBooks {
    if (_searchController.text.isEmpty) {
      print('Search text is empty, returning all books: ${_allBooks.length}');
      return _allBooks;
    }
    final query = _searchController.text.toLowerCase();
    print('Searching for: "$query"');
    final filtered = _allBooks.where((book) {
      final titleMatch = book.title.toLowerCase().contains(query);
      final authorMatch = book.author.toLowerCase().contains(query);
      print('Book: "${book.title}" by "${book.author}" - Title match: $titleMatch, Author match: $authorMatch');
      return titleMatch || authorMatch;
    }).toList();
    print('Found ${filtered.length} matching books');
    return filtered;
  }

  void _toggleSearch() {
    print('Toggle search called. Current state: $_isSearching');
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        print('Search cleared');
      }
    });
    print('Search state changed to: $_isSearching');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            // Professional header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.teal[800]!,
                    Colors.teal[600]!,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.menu_book,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ReadEra',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your Digital Library',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.library_books, size: 16, color: Colors.white70),
                        const SizedBox(width: 8),
                        Text(
                          '${_allBooks.length} Books',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Navigation items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 8),
                  
                  // Primary navigation section
                  _buildSectionHeader('LIBRARY'),
                  _DrawerItem(
                    icon: Icons.sync,
                    label: 'Reading Now',
                    subtitle: 'Continue where you left off',
                    isActive: true,
                  ),
                  _DrawerItem(
                    icon: Icons.menu_book,
                    label: 'Books & Documents',
                    subtitle: 'All your books',
                  ),
                  _DrawerItem(
                    icon: Icons.star,
                    label: 'Favorites',
                    subtitle: 'Your starred books',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Reading lists section
                  _buildSectionHeader('READING LISTS'),
                  _DrawerItem(
                    icon: Icons.access_time,
                    label: 'To Read',
                    subtitle: 'Books in your queue',
                  ),
                  _DrawerItem(
                    icon: Icons.check_circle,
                    label: 'Have Read',
                    subtitle: 'Completed books',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Organization section
                  _buildSectionHeader('ORGANIZE'),
                  _DrawerItem(
                    icon: Icons.person,
                    label: 'Authors',
                    subtitle: 'Browse by author',
                  ),
                  _DrawerItem(
                    icon: Icons.local_offer,
                    label: 'Series',
                    subtitle: 'Book series',
                  ),
                  _DrawerItem(
                    icon: Icons.collections_bookmark,
                    label: 'Collections',
                    subtitle: 'Custom collections',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // File management section
                  _buildSectionHeader('FILES'),
                  _DrawerItem(
                    icon: Icons.layers,
                    label: 'Formats',
                    subtitle: 'PDF, EPUB, etc.',
                  ),
                  _DrawerItem(
                    icon: Icons.folder,
                    label: 'Folders',
                    subtitle: 'Browse folders',
                  ),
                  _DrawerItem(
                    icon: Icons.download,
                    label: 'Downloads',
                    subtitle: 'Downloaded books',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // System section
                  _buildSectionHeader('SYSTEM'),
                  _DrawerItem(
                    icon: Icons.delete_outline,
                    label: 'Trash',
                    subtitle: 'Deleted books',
                    isDestructive: true,
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.teal[100],
                    child: Icon(Icons.person, size: 20, color: Colors.teal[700]),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Account',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Free Plan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.settings, size: 20, color: Colors.grey[600]),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search books...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  print('Text changed to: "$value"');
                  setState(() {});
                },
              )
            : const Text('Books & documents', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
        ],
      ),
      body: Column(
        children: [
          // Debug info
          if (_isSearching)
            Container(
              width: double.infinity,
              color: Colors.orange[100],
              padding: const EdgeInsets.all(8),
              child: Text(
                'DEBUG: Search mode: $_isSearching, Text: "${_searchController.text}", Results: ${_filteredBooks.length}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          Expanded(
            child: _filteredBooks.isEmpty && _searchController.text.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No books found for "${_searchController.text}"',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = _filteredBooks[index];
                      return BookCard(
                        image: book.image,
                        title: book.title,
                        author: book.author,
                        fileInfo: book.fileInfo,
                        isStarred: book.isStarred,
                        isRecent: book.isRecent,
                        isCompleted: book.isCompleted,
                        isOnShelf: book.isOnShelf,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class Book {
  final String image;
  final String title;
  final String author;
  final String fileInfo;
  final bool isStarred;
  final bool isRecent;
  final bool isCompleted;
  final bool isOnShelf;

  Book({
    required this.image,
    required this.title,
    required this.author,
    required this.fileInfo,
    this.isStarred = false,
    this.isRecent = false,
    this.isCompleted = false,
    this.isOnShelf = false,
  });
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool isActive;
  final bool isDestructive;
  const _DrawerItem({
    required this.icon,
    required this.label,
    this.subtitle,
    this.isActive = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? Colors.teal.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isActive ? Border.all(color: Colors.teal.withOpacity(0.3)) : null,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive 
                ? Colors.teal.withOpacity(0.2)
                : isDestructive 
                    ? Colors.red.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive 
                ? Colors.teal[700]
                : isDestructive 
                    ? Colors.red[600]
                    : Colors.grey[600],
          ),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isDestructive ? Colors.red[600] : Colors.grey[800],
          ),
        ),
        subtitle: subtitle != null 
            ? Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              )
            : null,
        onTap: () {
          Navigator.pop(context);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String fileInfo;
  final bool isStarred;
  final bool isRecent;
  final bool isCompleted;
  final bool isOnShelf;

  const BookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.fileInfo,
    this.isStarred = false,
    this.isRecent = false,
    this.isCompleted = false,
    this.isOnShelf = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.teal[900],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                image,
                width: 70,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.book, size: 40),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(author, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  Text(fileInfo, style: const TextStyle(fontSize: 13, color: Colors.white54)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.star, color: isStarred ? Colors.amber : Colors.white54),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, color: isRecent ? Colors.amber : Colors.white54),
                      const SizedBox(width: 16),
                      Icon(Icons.check, color: isCompleted ? Colors.amber : Colors.white54),
                      const SizedBox(width: 16),
                      Icon(Icons.library_books, color: isOnShelf ? Colors.amber : Colors.white54),
                      const Spacer(),
                      Icon(Icons.more_vert, color: Colors.white54),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
