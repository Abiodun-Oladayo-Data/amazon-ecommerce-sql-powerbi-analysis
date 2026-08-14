** Final Business Insights & Recommendations **
1. Revenue is heavily concentrated in a few product categories

Key Finding:
The business generated ₹78.59M in total revenue. SET was the largest category at approximately ₹39.2M, followed by KURTA at ₹21.3M and Western Dress at ₹11.2M. Together, these three categories account for the overwhelming majority of sales revenue.

Business Impact:
Overall sales performance is highly dependent on a relatively small number of product categories. Strong performance in SET and KURTA therefore has a disproportionate effect on total revenue, while disruption or declining demand in these categories presents concentration risk.

Recommendation:
Prioritize inventory availability, merchandising, and promotional planning for the strongest categories. At the same time, investigate whether lower-performing categories have growth potential or whether inventory allocation should be reduced in favor of higher-demand products.

2. A small group of product styles generates significantly higher revenue

Key Finding:
Among individual product styles, JNE3797 generated approximately ₹2.9M, making it the highest-revenue style, followed by J0230 at approximately ₹1.9M. Revenue falls substantially across the remaining Top 10 styles.

Business Impact:
Specific styles appear to have significantly stronger customer demand than much of the broader product assortment. These products may therefore play an important role in category-level performance.

Recommendation:
Maintain adequate inventory for consistently high-performing styles and investigate the characteristics driving their performance—such as category, pricing, size availability, or promotional activity—to determine whether successful patterns can be replicated across other products.

3. Revenue is geographically concentrated in several major states

Key Finding:
Maharashtra generated approximately ₹13.3M, the highest revenue among states, followed by Karnataka at ₹10.5M. Telangana, Uttar Pradesh, and Tamil Nadu were also among the leading markets.

Business Impact:
A substantial portion of sales originates from a relatively small number of geographic markets. These regions represent particularly important customer bases and may justify greater operational and marketing attention.

Recommendation:
Prioritize inventory positioning, fulfillment capacity, and targeted marketing in high-revenue states. Further analysis should also investigate why these markets outperform others and whether similar customer acquisition strategies could increase sales in underperforming regions.

4. Revenue declined across the comparable monthly periods

Key Finding:
Monthly revenue decreased from approximately ₹28.8M in April to ₹26.2M in May and ₹23.4M in June, representing an approximately 18.8% decline from April to June.

Business Impact:
The downward movement suggests weakening sales performance during the observed period and warrants further investigation into possible drivers such as order volume, product demand, cancellations, pricing, or seasonal effects.

Recommendation:
Monitor the trend over a longer reporting period and investigate the underlying drivers of the decline by category, geography, order status, and product style before making major commercial decisions.

Important limitation:
The source dataset covers March 31 through June 29, 2022. March contains only one day and was therefore excluded from the comparative monthly trend. June contains 29 days and is nearly complete, but this limitation should still be acknowledged.

5. Amazon-managed fulfillment accounts for the majority of revenue

Key Finding:
Amazon fulfillment generated approximately ₹54.32M (69.12%) of revenue, compared with approximately ₹24.27M (30.88%) through Merchant fulfillment.

Business Impact:
The majority of revenue is associated with Amazon-managed fulfillment, indicating that this channel plays an important role in the current sales operation.

Recommendation:
Evaluate whether Amazon fulfillment's larger revenue contribution is driven simply by greater order volume or whether it also provides stronger performance in areas such as order value, delivery completion, cancellations, and returns. This would help determine the appropriate future balance between Amazon and Merchant fulfillment.

6. Order status and data quality must be considered when interpreting revenue

Key Finding:
During the SQL analysis, we identified cancelled orders associated with revenue amounts in the source data, alongside missing values in fields such as amount and shipping-location information.

Business Impact:
Simply summing the raw amount column can potentially overstate realized sales if cancelled or otherwise unsuccessful transactions are treated as completed revenue. Data-quality issues can therefore materially affect business interpretation.

Recommendation:
Clearly define the organization's revenue-recognition rule before using the dataset for financial reporting. Future reporting should distinguish gross order value from realized/completed revenue and separately monitor cancelled and returned orders. Missing and inconsistent fields should continue to be validated before KPI calculation.

Executive Summary

The analysis shows that Amazon e-commerce sales generated ₹78.59M in revenue across approximately 120K orders and 117K units, with an average order value of ₹695.33. Revenue was strongly concentrated in the SET and KURTA categories, specific high-performing product styles, and major geographic markets led by Maharashtra and Karnataka. Amazon-managed fulfillment accounted for approximately 69% of revenue.

Across comparable monthly periods, revenue declined from ₹28.8M in April to ₹23.4M in June, warranting further investigation into the drivers of the decline. The analysis also highlighted the importance of carefully defining revenue because cancelled orders and source-data quality issues can affect financial interpretation.