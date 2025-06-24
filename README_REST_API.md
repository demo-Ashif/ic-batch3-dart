# REST API Learning Module for Dart Beginners

This comprehensive learning module covers REST APIs, HTTP operations, and asynchronous programming in Dart. It's designed specifically for beginners to understand and practice real-world API development concepts.

## 📚 What You'll Learn

### 1. REST Protocol
- Understanding REST principles
- Resource-based architecture
- Stateless communication
- HTTP as the underlying protocol

### 2. HTTP Methods (GET, POST, PUT, PATCH, DELETE)
- When and how to use each method
- Request/response patterns
- Status codes and their meanings
- Idempotency and safety

### 3. Headers and Authentication
- Common HTTP headers
- Content-Type and Accept headers
- Authentication methods (API Key, Bearer Token, Basic Auth)
- Security best practices

### 4. API Calling with HTTP Package
- Making HTTP requests in Dart
- Handling responses and errors
- Setting headers and request bodies
- Working with different HTTP methods

### 5. JSON Data Parsing
- Converting between JSON and Dart objects
- Creating model classes
- Handling complex JSON structures
- Error handling in parsing

### 6. Future and Await
- Asynchronous programming concepts
- Understanding Futures
- Using await keyword
- Parallel vs sequential execution
- Error handling in async code

### 7. Streams for Live Data
- Real-time data handling
- API polling with streams
- Stream transformations
- Error handling in streams
- Stream controllers and broadcast streams

### 8. API Response Caching and Optimization
- In-memory caching strategies
- Cache invalidation
- Performance optimization
- Request batching and compression

## 🚀 Getting Started

### Prerequisites
- Dart SDK (version 3.7.0 or higher)
- Basic understanding of Dart syntax
- Internet connection for API calls

### Installation

1. Clone or download this project
2. Install dependencies:
```bash
dart pub get
```

### Running Examples

#### Run All Examples
```bash
dart run lib/main.dart
```

#### Run Individual Examples

1. **Basic HTTP Methods:**
```bash
dart run lib/examples/01_basic_http_methods.dart
```

2. **JSON Parsing:**
```bash
dart run lib/examples/02_json_parsing.dart
```

3. **Future and Await:**
```bash
dart run lib/examples/03_future_await.dart
```

4. **Streams:**
```bash
dart run lib/examples/04_streams.dart
```

5. **Caching and Optimization:**
```bash
dart run lib/examples/05_caching_optimization.dart
```

## 📖 Learning Path

### Step 1: Understanding REST and HTTP (Theory)
Start by reading the comments in `lib/rest_api_learning.dart` for:
- REST protocol explanation
- HTTP methods overview
- Headers and authentication concepts

### Step 2: Basic HTTP Operations (Practice)
Run `01_basic_http_methods.dart` to see:
- GET requests for reading data
- POST requests for creating data
- PUT requests for updating data
- DELETE requests for removing data

### Step 3: JSON Data Handling (Practice)
Run `02_json_parsing.dart` to learn:
- Creating model classes
- Converting JSON to Dart objects
- Handling complex JSON structures
- Error handling in parsing

### Step 4: Asynchronous Programming (Practice)
Run `03_future_await.dart` to understand:
- How Futures work
- Using await for async operations
- Parallel vs sequential execution
- Error handling in async code

### Step 5: Real-time Data with Streams (Practice)
Run `04_streams.dart` to explore:
- Basic stream operations
- API polling with streams
- Stream transformations
- Real-time data simulation

### Step 6: Performance Optimization (Practice)
Run `05_caching_optimization.dart` to learn:
- Simple and advanced caching
- Performance comparisons
- Cache invalidation strategies
- Optimization techniques

## 🔧 API Used for Examples

This module uses [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - a free fake API for testing and prototyping. It provides:
- Posts: `/posts`
- Users: `/users`
- Comments: `/comments`
- Albums: `/albums`
- Photos: `/photos`
- Todos: `/todos`

## 📝 Key Concepts Explained

### REST Protocol
REST (Representational State Transfer) is an architectural style for designing networked applications. It uses HTTP as the underlying protocol and treats everything as a resource.

**Key Principles:**
- **Stateless**: Each request contains all information needed
- **Client-Server**: Separation of concerns
- **Cacheable**: Responses can be cached
- **Uniform Interface**: Consistent way to interact with resources
- **Layered System**: Can be composed of multiple layers

### HTTP Methods

| Method | Purpose | Idempotent | Safe |
|--------|---------|------------|------|
| GET | Retrieve data | ✅ | ✅ |
| POST | Create data | ❌ | ❌ |
| PUT | Update entire resource | ✅ | ❌ |
| PATCH | Partial update | ✅ | ❌ |
| DELETE | Remove resource | ✅ | ❌ |

### Future and Await
- **Future**: Represents a value that will be available at some time in the future
- **Await**: Keyword used to wait for a Future to complete
- **Async**: Keyword that marks a function as asynchronous

### Streams
- **Stream**: A sequence of asynchronous events
- **StreamController**: Used to create and control streams
- **Broadcast Stream**: Can have multiple listeners
- **Stream Transformation**: Using map, where, etc.

### Caching
- **Cache Hit**: Data found in cache
- **Cache Miss**: Data not found in cache
- **TTL (Time To Live)**: How long data stays in cache
- **LRU (Least Recently Used)**: Cache eviction strategy

## 🛠️ Common Patterns

### Making API Calls
```dart
final response = await http.get(
  Uri.parse('https://api.example.com/data'),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer your-token',
  },
);

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  // Process data
}
```

### Creating Model Classes
```dart
class User {
  final int id;
  final String name;
  final String email;
  
  User({required this.id, required this.name, required this.email});
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
```

### Error Handling
```dart
try {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // Success
  } else {
    // Handle error status
  }
} catch (e) {
  // Handle network/parsing errors
}
```

### Caching Pattern
```dart
Future<Map<String, dynamic>> getCachedData(String url) async {
  // Check cache first
  final cachedData = cache.get(url);
  if (cachedData != null) {
    return cachedData;
  }
  
  // Fetch from API
  final response = await http.get(Uri.parse(url));
  final data = jsonDecode(response.body);
  
  // Cache the result
  cache.set(url, data);
  
  return data;
}
```

## 🎯 Best Practices

### API Calls
1. Always handle errors with try-catch
2. Check HTTP status codes
3. Use appropriate headers
4. Implement timeouts for long-running requests
5. Use HTTPS for production APIs

### JSON Parsing
1. Create model classes for type safety
2. Handle null values appropriately
3. Validate data before using
4. Use factory constructors for JSON conversion

### Asynchronous Programming
1. Use async/await for readability
2. Handle errors in async functions
3. Use Future.wait for parallel operations
4. Avoid blocking the main thread

### Caching
1. Set appropriate TTL values
2. Implement cache invalidation strategies
3. Monitor cache hit rates
4. Use different cache levels (memory, disk, network)

### Performance
1. Use parallel requests when possible
2. Implement request batching
3. Use compression for large responses
4. Cache frequently accessed data

## 🧪 Testing with Postman

While learning, you can use Postman to:
1. Test API endpoints manually
2. Understand request/response formats
3. Set up authentication
4. Create collections for different APIs
5. Generate code snippets

### Postman Setup
1. Download and install Postman
2. Create a new collection
3. Add requests for different HTTP methods
4. Set up environment variables for base URLs
5. Test the JSONPlaceholder API endpoints

## 📚 Additional Resources

- [Dart HTTP Package Documentation](https://pub.dev/packages/http)
- [REST API Tutorial](https://restfulapi.net/)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

## 🤝 Contributing

Feel free to:
- Add more examples
- Improve error handling
- Add new optimization techniques
- Create additional model classes
- Enhance documentation

## 📄 License

This project is for educational purposes. Feel free to use and modify as needed.

---

**Happy Learning! 🚀**

Start with the basic examples and gradually move to more advanced concepts. Practice each concept thoroughly before moving to the next one. 