# Creating an ERD in 3rd Normal Form (3NF)

## Introduction
Create an Entity-Relationship Diagram (ERD) in the 3rd Normal Form (3NF) for the Car Manufacturer Database. 3NF is a database normalization form that ensures data is logically stored to reduce redundancy and improve data integrity.

## Normalization

### 1NF (First Normal Form)
- <strong>Every</strong> table has a primary key. (No composite keys should be used.)
- Each column contains only one value.
- Follow best practices for naming columns and tables.
    - Column and table names should follow these rules:
        - Be lowercase
        - Use underscores to separate words
        - Singular 

### 2NF (Second Normal Form)
- Each non-key attribute is fully dependent on the primary key. This means that all columns in a table that are part of the same record are dependent on the primary key.

### 3NF (Third Normal Form)
- All columns in a table are fully dependent on the primary key. This means that if we refer to a record, we hope that we refer to the correct record.
- This form shows itself as Linking tables using the relationships between entities.

## Steps to Create a 3NF ERD

### 1. Look at Data
Always use data to create an ERD. This will help you understand the relationships between entities and attributes.

### 2. Find Entities (Table Names)
Identify the main entities in your system. An entity represents a real-world object or concept, such as `customer`, `order`, or `product`.

### 3. Define Attributes (Column Names)
For each entity, list its attributes. Attributes are properties or characteristics of an entity, such as `customer_id`, `customer_fname`, `customer_lname`, `order_date`, etc.

### 4. Determine Data Types
When defining attributes, determine the data types for each attribute. Common data types include `int`, `varchar`, `date`, `float`, etc.

Make sure that all primary keys have the following settings checked: `PK (Primary Key)`, `NN (Not Null)`, `UN (Unsigned)`, `AI (Auto Increment)`.

All other columns should have `NN` checked unless there is a good reason to allow NULL values.

### 5. Establish Relationships
Identify the relationships between entities. Determine how entities are related to each other, such as a `customer` placing an `order`.

### 6. Draw the ERD
Use an ERD tool to visually represent the entities, attributes, primary keys, and relationships.

## Example
Here is a simple example of a 3NF ERD for a customer order system:

- **customer**: `customer_id` (PK), `customer_fname`, `customer_lname`, `customer_email`
- **order**: `order_id` (PK), `order_date`, `customer_id` (FK)
- **product**: `product_id` (PK), `product_name`, `product_price`
- **order_detail**: `order_detail_id` (PK), `order_id` (FK), `product_id` (FK), `quantity`

