
## **Introduction**

The **Exploring Adult BMI** project focuses on analyzing body mass index (BMI) data for adults. This README provides detailed instructions for setting up the project, running the application, and understanding its functionality.

## **Table of Contents**

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)

## **Prerequisites**

Before you begin, ensure you have the following installed:

- **MySQL Workbench**: For database management.
- **Python 3.x**: For running the application.
- **IntelliJ IDEA** (or any preferred IDE): For importing and executing Python code.

## **Getting Started**

Follow the instructions below to set up the **Exploring Adult BMI** project on your local system.

## **Setup Instructions**

### **Step 1: Import SQL Code into MySQL Workbench**

1. Open **MySQL Workbench**.
2. Click on the **File** menu, then select **Import**.
3. Locate and select the `Exploring_Adult_BMI_Sql_Code.sql` file from your local directory.
4. Click **Open** to import the SQL code into your MySQL database.

### **Step 2: Run the Code and Build the Database**

1. In the **Navigator** panel, find the imported SQL file.
2. Click the **Execute** button (lightning bolt icon) to run the SQL code.
3. This will create the necessary database and tables for the project.

### **Step 3: Import Python Source Code**

1. Open **IntelliJ IDEA** (or your preferred IDE).
2. Go to **File** > **Open** and select the `Python_Source_Code` folder.
3. Inside the folder, locate and open the `app.py` file.

### **Step 4: Install Required Python Libraries**

If your project includes a `requirements.txt` file, install the necessary libraries by running:

pip install -r requirements.txt

### **Step 5: Run the Application**

1. In IntelliJ IDEA, right-click on `app.py` and select **Run 'app'**.
2. After the application starts successfully, you will see output in the console indicating that the server is running.
   - The console may also provide a hyperlink; if it does, click the hyperlink to open the application in your web browser.
3. You will be redirected to a webpage where you can enter the required inputs.
4. In the input fields, enter a valid **Country** and **Year**.
5. Click the **Submit** button to view the results displayed on the results page.
