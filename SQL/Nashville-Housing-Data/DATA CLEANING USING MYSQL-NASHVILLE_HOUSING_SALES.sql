-- Create the database
CREATE DATABASE NashvilleHousing;
USE NashvilleHousing;

-- Create a table for the dataset with relevant columns
CREATE TABLE HousingData (
    UniqueID INT, -- Unique identifier for each entry
    ParcelID VARCHAR(50), -- Unique identifier for the parcel of land
    LandUse VARCHAR(50), -- Type of land use (e.g., residential, commercial)
    PropertyAddress VARCHAR(255), -- Address of the property
    SaleDate DATE, -- Date of sale
    SalePrice INT, -- Sale price of the property
    LegalReference VARCHAR(100), -- Legal reference or document for the property
    SoldAsVacant VARCHAR(10), -- Indicator if the property was sold as vacant
    OwnerName VARCHAR(255), -- Name of the property owner
    OwnerAddress VARCHAR(255), -- Address of the property owner
    Acreage FLOAT, -- Size of the land in acres
    TaxDistrict VARCHAR(100), -- Tax district of the property
    LandValue FLOAT, -- Value of the land
    BuildingValue FLOAT, -- Value of the building
    TotalValue FLOAT, -- Total value (land + building)
    YearBuilt INT, -- Year the property was built
    Bedrooms INT, -- Number of bedrooms in the property
    FullBath INT, -- Number of full bathrooms in the property
    HalfBath INT -- Number of half bathrooms in the property
);

-- Select all data from the HousingData table
SELECT *
FROM housingdata;

-- Select PropertyAddress where it is NULL
SELECT PropertyAddress
FROM housingdata
WHERE PropertyAddress IS NULL;

-- Resolve missing PropertyAddress by joining on ParcelID, updating with non-null values from another row
SELECT 
    a.ParcelID,
    a.PropertyAddress AS PropertyAddressA,
    b.ParcelID AS ParcelIDB,
    b.PropertyAddress AS PropertyAddressB,
    COALESCE(a.PropertyAddress, b.PropertyAddress) AS ResolvedPropertyAddress
FROM 
    housingdata a
JOIN 
    housingdata b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
WHERE 
    a.PropertyAddress IS NULL;

-- Update the PropertyAddress for rows with NULL value, using COALESCE to take the first non-null address from a matching row
UPDATE housingdata a
JOIN housingdata b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL
  AND a.UniqueID IS NOT NULL;

-- Disable safe updates to allow updates without restrictions
SET SQL_SAFE_UPDATES=0;

-- Split PropertyAddress into Address and City based on the comma separator
SELECT 
    SUBSTRING_INDEX(PropertyAddress, ',', 1) AS Address, -- Extracts the address part before the first comma
    SUBSTRING_INDEX(PropertyAddress, ',', -1) AS City -- Extracts the city part after the last comma
FROM housingdata;

-- Add new columns for split address and city
ALTER TABLE housingdata
ADD COLUMN PropertySplitAddress NVARCHAR(255), -- To store the address part
ADD COLUMN PropertySplitCity NVARCHAR(255); -- To store the city part

-- Update the new columns with the appropriate values from PropertyAddress
UPDATE housingdata
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);

UPDATE housingdata
SET PropertyCity = SUBSTRING_INDEX(PropertyAddress, ',', -1);

-- Split OwnerAddress into Address, City, and State using commas as delimiters
SELECT 
    SUBSTRING_INDEX(OwnerAddress, ',', 1) AS OwnerSplitAddress, -- Extracts the address part
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) AS OwnerSplitCity, -- Extracts the city part
    SUBSTRING_INDEX(OwnerAddress, ',', -1) AS OwnerSplitState -- Extracts the state part
FROM housingdata;

-- Add new columns for the split owner address, city, and state
ALTER TABLE housingdata
ADD COLUMN OwnerSplitAddress NVARCHAR(255), -- To store the owner’s address
ADD COLUMN OwnerSplitCity NVARCHAR(255), -- To store the owner’s city
ADD COLUMN OwnerSplitState NVARCHAR(255); -- To store the owner’s state

-- Update the OwnerSplitAddress, OwnerSplitCity, and OwnerSplitState columns with the extracted values
UPDATE housingdata
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

UPDATE housingdata
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1);

UPDATE housingdata
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress, ',', -1);

-- Analyze and count the distinct values in SoldAsVacant field
SELECT SoldAsVacant, COUNT(SoldAsVacant) AS Count
FROM housingdata
GROUP BY SoldAsVacant
ORDER BY Count;

-- Update the SoldAsVacant column to replace 'Y' and 'N' with 'Yes' and 'No'
UPDATE housingdata
SET SoldAsVacant = CASE
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END;

-- Use a Common Table Expression (CTE) to identify and delete duplicate rows
WITH RowNumCTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM housingdata
)
SELECT * 
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;

-- Delete duplicates based on the row number provided by the CTE
DELETE a
FROM housingdata a
JOIN (
    SELECT UniqueID
    FROM RowNumCTE
    WHERE row_num > 1
) b
ON a.UniqueID = b.UniqueID;

-- Delete duplicates without using CTE by using a ROW_NUMBER() function directly in the subquery
DELETE a
FROM housingdata a
JOIN (
    SELECT UniqueID, 
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM housingdata
) b
ON a.UniqueID = b.UniqueID
WHERE b.row_num > 1;

-- Drop unnecessary columns from the HousingData table to clean up the schema
ALTER TABLE housingdata
DROP COLUMN OwnerAddress; -- Drop the OwnerAddress column

ALTER TABLE housingdata
DROP COLUMN TaxDistrict; -- Drop the TaxDistrict column

ALTER TABLE housingdata
DROP COLUMN PropertyAddress; -- Drop the PropertyAddress column

ALTER TABLE housingdata
DROP COLUMN SaleDate; -- Drop the SaleDate column
