# Nashville Housing Data

This project involves working with housing data from Nashville, focusing on cleaning and transforming the dataset, resolving missing values, and analyzing key fields. The goal is to provide insights into the property and ownership data, ensuring it's ready for further analysis or reporting.

## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Contributing](#contributing)
4. [License](#license)

## Installation

### Prerequisites
Before you begin, ensure you have the following installed:
- MySQL or a compatible database to store the data
- SQL client (e.g., MySQL Workbench or command-line client)
- A basic knowledge of SQL and database management

### Steps to install:
1. Clone the repository:
    ```bash
    git clone https://github.com/username/nashville-housing-data.git
    ```

2. Navigate into the project directory:
    ```bash
    cd nashville-housing-data
    ```

3. Set up the database and tables:
    - Open MySQL and create the `NashvilleHousing` database:
      ```sql
      CREATE DATABASE NashvilleHousing;
      ```

    - Use the `NashvilleHousing` database:
      ```sql
      USE NashvilleHousing;
      ```

    - Create the housing data table and import your dataset.

4. Run the SQL scripts to clean and manipulate the data:
    - This includes removing duplicates, splitting address fields, updating columns, and resolving missing values.

## Usage

To use this project:

1. Import your housing data into the `housingdata` table in the MySQL database. 
2. Run SQL scripts to clean and transform the data as per the project's requirements:
    - Removing duplicates with the `ROW_NUMBER` function
    - Resolving missing values for `PropertyAddress` by using `COALESCE`
    - Splitting `PropertyAddress` and `OwnerAddress` into separate components
    - Updating the `SoldAsVacant` field to replace 'Y' and 'N' with 'Yes' and 'No'
License
This project is licensed under the MIT License - see the LICENSE.md file for details.
CREDIT:AlextheAnalyst
