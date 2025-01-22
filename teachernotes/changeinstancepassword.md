# Changing the Instance password in AWS

If a student has forgotten the password for their AWS instance, you can reset it using the AWS Management Console. This guide will show you how to change the password for an AWS instance.

## Steps

1. **Go to the Instance in AWS**:
    - Log in to the AWS Management Console.
    - Navigate to the `EC2` dashboard.
    - Click on `Instances` in the left-hand menu.

2. **Select the Instance**:
    - Click on the instance for which you want to change the password.

3. **Start the Instance**:
    - If the instance is not running, start it by right-clicking on the instance and selecting `Instance State` > `Start`.

4. **Connect to the Instance**:
    - Select the instance and click on the `Connect` button.
    - Select the `Session Manager` option. You may need to wait a few moments to select the `Connect` button.

5. **Switch to the student User**:
    - Once connected, switch to the `student` user by running the following command:
      ```bash
      sudo su student
      ```
    
6. **Change the Password**:
    - To change the password for the `student` user, run the following command:
      ```bash
      sudo passwd student
      ```
    - You will be prompted to enter a new password. Follow the instructions to set a new password.