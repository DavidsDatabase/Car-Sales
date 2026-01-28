# Car-Sales

### Project Overview

This project focuses on car sales from 1980s to 2010s with many different variables affecting sales such as car make and model, manufacturing year, odometer reading, and condition. We aim to determine which factors affect selling prices and find which yields the most profit. Using SQL, this project will answer key business questions around vehicle information, attributes, and seller performance. 

### About the Data

The primary dataset can be found on <https://www.kaggle.com/datasets/syedanwarafridi/vehicle-sales-data/data/>. 

### Tools Used

- Excel - Data Cleaning
- SQL - EDA

### Data Cleaning/Preparation

1. Data loading
2. Data Cleaning and Sorting
3. Data Formatting and Transforming

### Exploratory Data Analysis (EDA)

EDA was performed to answer key questions, such as, but not limited to:

1. How do selling prices vary by make, model, and body type?

2. Do vehicles typically sell above or below market value (MMR)?

3. What is the average price difference between automatic and manual vehicles?

4. How do vehicle age, mileage, and condition impact selling price?

5. Which states and sellers generate the highest revenue?

6. Are there seasonal trends in used car sales and pricing?

### Results/Findings

1. Prices vary drastically depending on the car's make, model, and body type. We found that brands such as Rolls-Royce, Ferrari, Lamborghini yielded high average sold cars compared to other brands. SUVs consistently achieve higher average selling prices relative to sedans, reflecting stronger market valuation.

2. Analysis shows that 46.3% of cars sold were above the MMR, indicating over half of the cars yielded a loss in profit.

3. The average price difference between automatic and manual cars is around $2,400. The average price for automatic cars is $13,523, where the average price for manual cars is $11,137.

4. The older the car is, the less selling price the car would be. Odometer readings shows that high values would result in lower selling prices.

5. Florida, California, and Pennsylvania were the top 3 states that had the highest revenue. Ford Motors, Nissan-Infiniti lt, and Hertz corporation were the top 3 sellers that had the highest revenue. 
   
<img width="151" height="213" alt="image" src="https://github.com/user-attachments/assets/524779e2-fd16-4846-975d-ae6c3ce6142a" />
<img width="296" height="208" alt="image" src="https://github.com/user-attachments/assets/869ad781-4349-49ab-be0b-78d11df2bce0" />

6. Seasonal trends indicate that winter significantly outperforms spring and summer in total sales volume.


### Recommendations

Based on the analysis, we recommend the following actions:

We recommend car sellers to focus more on SUVs than sedans as the average selling price is higher on SUVs than sedans. Also, our analysis shows that cars sold during the Winter season had more than triple the sales compared to Spring and Summer. Sellers should focus on selling cars during the Winter season. Cars with high odometer readings and are older would yield a lower selling price, which could lead to a loss in profit compared to newer cars with lower odometer readings. 

### Limitations

The dataset had several limitations such as missing values, outliers, and labels that could have been segmented together. We made the choice to not omit any missing values as there were many rows of data that had missing values and it would had been a great loss of data if we had removed them. 


