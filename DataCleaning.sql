-- Cleaning Data in SQL Queries


SELECT *
FROM PortfolioProject..NashVilleHousing


-- Standardize Date Format

SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM PortfolioProject..NashVilleHousing


UPDATE PortfolioProject..NashVilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE PortfolioProject..NashVilleHousing
ADD SaleDateConverted Date;

UPDATE PortfolioProject..NashVilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


-- Populate The PropertyAddress

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashVilleHousing a
JOIN PortfolioProject..NashVilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


UPDATE a
SET PropertyAddress= ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashVilleHousing a
JOIN PortfolioProject..NashVilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


-- Breaking out address into individual columns (address, city, state)

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS Address
FROM PortfolioProject..NashVilleHousing


ALTER TABLE PortfolioProject..NashVilleHousing
ADD PropertyAddressSplit nvarchar(255);

ALTER TABLE PortfolioProject..NashVilleHousing
ADD PropertyAddressCity nvarchar(255);

UPDATE PortfolioProject..NashVilleHousing
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

UPDATE PortfolioProject..NashVilleHousing
SET PropertyAddressCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

SELECT *
FROM PortfolioProject..NashVilleHousing


SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProject..NashVilleHousing


ALTER TABLE PortfolioProject..NashVilleHousing
ADD OwnerAddressSplit nvarchar(255);

ALTER TABLE PortfolioProject..NashVilleHousing
ADD OwnerAddressCity nvarchar(255);

ALTER TABLE PortfolioProject..NashVilleHousing
ADD OwnerAddressState nvarchar(255);


UPDATE PortfolioProject..NashVilleHousing
SET OwnerAddressSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

UPDATE PortfolioProject..NashVilleHousing
SET OwnerAddressCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

UPDATE PortfolioProject..NashVilleHousing
SET OwnerAddressState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-- Change Y and N to Yes and No in 'SoldASVacant' field

SELECT DISTINCT(SoldAsVacant)
FROM PortfolioProject..NashVilleHousing


SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM PortfolioProject..NashVilleHousing


UPDATE PortfolioProject..NashVilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END


-- Remove Duplicate


WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

FROM PortfolioProject..NashVilleHousing
)
SELECT * 
FROM RowNumCTE
WHERE row_num>1
--ORDER BY PropertyAddress


--DELETE Unused Columns

SELECT *
FROM PortfolioProject..NashVilleHousing

ALTER TABLE PortfolioProject..NashVilleHousing
DROP COLUMN OwnerAddress, PropertyAddress, SaleDate, TaxDistrict
