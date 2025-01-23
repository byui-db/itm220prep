# Installing Airport Database Locally

## Overview

**Warning: The database is ~8GB. Please only install if you have enough space and are fine with long wait times to process queries**

In this guide, we will walk you through the process of installing the Airport Database locally on your machine. This will allow you to run queries and test your SQL skills without needing to connect to a remote server.

## Steps

### 1. Download the Database
- Navigate to the [Airport Database](https://drive.google.com/drive/folders/1U-nt0yBgTsKFexJEvRQAbMewd7VbM3ka?usp=sharing) on Google Drive.
- You will need to log in with your BYU-I account to access the files.
- Download the `airportdb_dump.sql` and `passenger_modifications.sql` files to your local machine.

### 2. Install MySQL Workbench and Server
- If you don't already have MySQL Workbench and Server installed, download and install them from the [MySQL website](https://dev.mysql.com/downloads/).
- Follow the installation instructions for your operating system.

### 3. Create a New Database
- Log in to the MySQL server from the Terminal or Command Prompt.
- If you are using Windows, make sure the MySQL bin directory is added to your system PATH.
- Navigate to the directory where you downloaded the `airportdb_dump.sql` file.
- Run the following command to log in and load the database:
    ```bash
    mysql -u root -p < airportdb_dump.sql
    ```
- Enter your MySQL root password when prompted.
- The database will be created with the name `airportdb`. 
**This process may take a while due to the size of the database.**
- Once the database is created, run the following command to load the passenger modifications:
    ```bash
    mysql -u root -p airportdb < passenger_modifications.sql
    ```