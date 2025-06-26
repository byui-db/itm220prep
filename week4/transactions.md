# Transaction Overview

## Introduction
The following files are used to demonstrate the use of transactions in MySQL:
- `library_fe.sql`
- `library_transactions.sql`

Transactions are used to ensure that a series of SQL statements are executed as a single unit. If any of the statements fail, the entire transaction is rolled back. This ensures that the database remains in a consistent state.

## Instructions

1. **Create the database**
    - Run the following command to create the database:
    ```bash
    mysql -u student -p < library_fe.sql
    ```
    - Enter the password `student` when prompted.

    You can also open up workbench, load the file `library_fe.sql` and run the script.

2. **Update the Database for Book Checkouts**
    - Run the following command to update the database:
    ```bash
    mysql -u student -p < library_transactions.sql
    ```
    - Enter the password `student` when prompted.

    You can also open up workbench, load the file `library_transactions.sql` and run the script.

    The script will insert all relevant data into the database, will check out books to those in the database, and finally check in books that have been returned.

    A single transaction starts with the `START TRANSACTION` statement and ends with the `COMMIT` statement. If you comment back in the `ROLLBACK` statement, the transaction will be rolled back and the database will be in the same state as before the transaction started.
    
    To run these transactions one at a time, you need to highlight them then use either the `First Lightning Bolt` or the keyboard shortcut of `Ctrl(CMD)+Shift+Enter`.
