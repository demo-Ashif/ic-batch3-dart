# TO-DO List Manager ✅

A beginner-friendly Dart console application to manage tasks with status tracking.

## How to Run

```bash
dart run todo_list/main.dart
```

## Features

- **Add Tasks**: Create new tasks with descriptions
- **View All Tasks**: See all tasks with completion status
- **Mark Complete**: Mark tasks as completed
- **Remove Tasks**: Delete tasks from the list
- **View Completed**: See only completed tasks
- **Task Statistics**: View total, completed, and pending counts
- **Memory Storage**: Tasks stored in program memory
- **Task IDs**: Automatic ID assignment for easy reference

## How to Use

1. **Add Task**: Choose option 1 to add a new task
2. **View All**: Choose option 2 to see all tasks with status
3. **Mark Complete**: Choose option 3 to mark a task as done
4. **Remove Task**: Choose option 4 to delete a task
5. **View Completed**: Choose option 5 to see completed tasks
6. **Exit**: Choose option 6 to quit the program

## Task Status

- **⏳ Pending**: Task not yet completed
- **✅ Completed**: Task finished successfully

## Learning Objectives

This project covers:
- **Complex Data Structures**: List<Map<String, dynamic>> for tasks
- **List Methods**: where(), firstWhere(), remove() methods
- **Dynamic Data**: Using dynamic type for flexible data
- **Task Management**: CRUD operations (Create, Read, Update, Delete)
- **Status Tracking**: Boolean flags for task completion
- **Statistics**: Calculating counts and percentages
- **Data Filtering**: Filtering lists based on conditions
- **DateTime**: Using DateTime for timestamps

## Key Concepts Demonstrated

1. **Complex Maps**: Maps with different data types (String, bool, DateTime)
2. **List Filtering**: Using where() to filter tasks by status
3. **List Searching**: Using firstWhere() to find specific tasks
4. **Data Manipulation**: Adding, updating, and removing list items
5. **Status Management**: Boolean flags for task completion
6. **Statistics Calculation**: Counting completed vs pending tasks
7. **User Experience**: Clear status indicators and statistics
8. **Error Handling**: Validating task IDs and existence 