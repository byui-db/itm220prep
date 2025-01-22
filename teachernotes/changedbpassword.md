# Change User Password on MySQL Workbench

This guide will help you change the password for the `student` user on MySQL Workbench using a command as the root user.

## Steps

1. **Open MySQL Workbench**: Launch MySQL Workbench and connect to the root user using the password `C4nGet1n!`.

2. **Open SQL Editor**:
    - In the Navigator panel, click on the `SQL` icon to open a new SQL tab.

3. **Enter Command**:
    - In the SQL editor, enter the following command to change the password for the `student` user:
      ```sql
      ALTER USER 'student'@'localhost' IDENTIFIED BY 'new_password';
      ```

4. **Execute Command**:
    - Click the `Execute` button (lightning bolt icon) to run the command.

5. **Confirm Changes**:
    - Ensure that the command executed successfully by checking the output in the Action Output panel.
