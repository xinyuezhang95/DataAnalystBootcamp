/*

Cleaning Data in SQL Queries

*/

-- Step 0: check all the data
select *
from NashvilleHousing;

-- Step 1: Standardize Date Format
select SaleDate
from NashvilleHousing;

select SaleDate, convert(date, SaleDate)
from NashvilleHousing;

--Method 1:
update NashvilleHousing
set SaleDate = convert(Date, SaleDate);
--Notice that sometimes the above command doesn't work

--Method 2:
alter table NashvilleHousing
add SaleDateConverted Date;
update NashvilleHousing
set SaleDateConverted = convert(Date, SaleDate);

--Check results:
select SaleDateConverted, convert(date, SaleDate)
from NashvilleHousing;

-- Step 2: Populate Property Address 
select *
from NashvilleHousing
where PropertyAddress is null;

select *
from NashvilleHousing
--where PropertyAddress is null
order by ParcelID;
--Notice that records with the same ParcelID have the same PropertyAddress

--self join
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,
isnull(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
--we are joining based on the same ParcelID, but not the same record
where a.PropertyAddress is null;

--update records
update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;
--29 rows affected

-- Step 3: Break out Address into Individual Columns (Address, City, State)
select PropertyAddress
from NashvilleHousing;

select 
substring(PropertyAddress, 1, charindex(',', PropertyAddress) - 1) as Address,
charindex(',', PropertyAddress)
from NashvilleHousing;
--without '-1', it will include ',' in the Address column

select 
substring(PropertyAddress, 1, charindex(',', PropertyAddress) - 1) as Address,
substring(PropertyAddress, charindex(',', PropertyAddress) + 1, len(PropertyAddress)) as City
from NashvilleHousing;
--'+1' removes the comma, '+2' would remove the space in front of the city

alter table NashvilleHousing
add PropertySplitAddress nvarchar(255);
alter table NashvilleHousing
add PropertySplitCity nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = substring(PropertyAddress, 1, charindex(',', PropertyAddress) - 1);
update NashvilleHousing
set PropertySplitCity = substring(PropertyAddress, charindex(',', PropertyAddress) + 1, len(PropertyAddress));

select * 
from NashvilleHousing;

-- Step 4: Check owner address (Address, City, State)
select OwnerAddress
from NashvilleHousing;

--use a different method from substring: parsename
select 
PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
from NashvilleHousing;
--Parsename does things backward, and it only recognizes '.', so we need to replace ',' with '.'

select 
PARSENAME(Replace(OwnerAddress, ',', '.'), 3),
PARSENAME(Replace(OwnerAddress, ',', '.'), 2),
PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
from NashvilleHousing;

alter table NashvilleHousing
add OwnerSplitAddress nvarchar(255);
alter table NashvilleHousing
add OwnerSplitCity nvarchar(255);
alter table NashvilleHousing
add OwnerSplitState nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'), 3);
update NashvilleHousing
set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'), 2);
update NashvilleHousing
set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'), 1);

select * 
from NashvilleHousing;

-- Step 5: Change Y and N to Yes and No in 'Sold as Vacant' field
--check data
select distinct(SoldAsVacant), count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2;

--make sure the query works
select SoldAsVacant,
case when SoldAsVacant = 'Y' Then 'Yes'
	 when SoldAsVacant = 'N' Then 'No'
	 else SoldAsVacant
end
from NashvilleHousing;

--update the table
update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' Then 'Yes'
	 when SoldAsVacant = 'N' Then 'No'
	 else SoldAsVacant
end

-- Step 6: Remove duplicates
--It's not standard to delete raw data from tables. We can save the deleted data to a temp table

--use Row_Number() function with a window to select duplicated records
select *,
ROW_NUMBER() over (
partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference order by UniqueID) row_num
from NashvilleHousing
order by row_num desc;

--check duplicated records
select * 
from NashvilleHousing
where ParcelID = '081 15 0 472.00';

--Need to use CTE to apply the condition 'row_num > 1'
With RowNumCTE as (
select *,
ROW_NUMBER() over (
partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference order by UniqueID) row_num
from NashvilleHousing
)
select * 
from RowNumCTE
where row_num > 1
order by ParcelID;

--delete duplicated records with CTE
With RowNumCTE as (
select *,
ROW_NUMBER() over (
partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference order by UniqueID) row_num
from NashvilleHousing
)
delete
from RowNumCTE
where row_num > 1;
--104 rows affected

-- Step 7: Delete Unused Columns (clean the data to make it more usable)

alter table NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress

select *
from NashvilleHousing