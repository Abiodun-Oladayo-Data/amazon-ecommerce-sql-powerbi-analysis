# Project Journal

This journal documents the progress of the project from planning through deployment. It serves as a record of the decisions made, challenges encountered, lessons learned, and milestones completed.

---

# Session 1 – Project Setup

## Objectives

- Download the Amazon E-Commerce dataset.
- Organize the project folder structure.
- Prepare the development environment.

## Completed

- Downloaded and extracted the Kaggle dataset.
- Installed and verified MySQL Server.
- Installed and verified MySQL Workbench.
- Installed VS Code.
- Installed Git.
- Created the project folder structure.
- Created the GitHub repository.
- Created the project documentation structure.

## Lessons Learned

- Professional analytics projects begin with proper organization.
- A well-structured repository improves collaboration and maintainability.

---

# Session 2 – Data Understanding

## Objectives

- Explore the raw dataset.
- Identify the available columns.
- Perform an initial data quality assessment.

## Completed

- Reviewed the structure of the Amazon Sale Report dataset.
- Identified 22 business columns.
- Identified the exported `index` column.
- Identified the empty `Unnamed: 22` column.
- Verified that the Date column issue was only an Excel display problem.
- Confirmed that Order IDs appear complete.
- Identified potential missing values for later validation.

## Lessons Learned

- Raw business data should always be profiled before importing into a database.
- Data quality assessment is the first step in any analytics project.

---

# Session 3 – Project Planning

## Objectives

- Define the project scope.
- Establish business objectives.
- Design the future database.

## Completed

Created:

- Project Charter
- Data Dictionary
- Database Design
- Business Questions

Defined:

- Project objectives
- Business stakeholders
- KPIs
- Database design strategy
- Proposed relational tables

## Lessons Learned

- SQL development should be driven by business requirements rather than simply importing data.
- Database design should occur before database implementation.

---

# Session 4 – SQL Database Development & Data Loading

## Objectives

- Create the MySQL database environment for the project.
- Build a staging table that reflects the structure of the source dataset.
- Import the Amazon sales data into MySQL.
- Preserve the raw source data while preparing it for validation and cleaning.

## Completed

- Created the `amazon_ecommerce_db` MySQL database.
- Created a staging table for the Amazon sales dataset.
- Mapped the relevant source columns to the staging table.
- Excluded the unnecessary exported `index` column and empty `Unnamed: 22` column from the analytical workflow.
- Initially attempted to import the CSV through MySQL Workbench.
- Encountered import issues, including incorrect decimal-value errors and a stalled import process.
- Switched to `LOAD DATA LOCAL INFILE` as a more reliable loading method.
- Successfully loaded the source data into the staging environment.
- Preserved the staging table as the raw database layer before applying cleaning transformations.

## Challenges & Decisions

- The initial MySQL Workbench import method was not reliable for the dataset.
- Rather than modifying the source CSV solely to accommodate the import wizard, the loading approach was changed to `LOAD DATA LOCAL INFILE`.
- A staging-table architecture was used so that cleaning operations would not overwrite the originally imported data.

## Lessons Learned

- Data-loading methods may need to change when GUI-based import tools encounter datatype or performance issues.
- Maintaining a staging layer improves traceability and makes the cleaning process reproducible.
- Separating raw/staging data from cleaned analytical data is an important database design practice.

---

# Session 5 – Data Validation & Profiling

## Objectives

- Validate the data loaded into the MySQL staging table.
- Identify missing values, duplicates, and other data-quality issues.
- Profile important business fields before applying cleaning transformations.
- Determine which issues required correction and which should be retained and documented.

## Completed

- Validated the successfully imported staging data using SQL queries.
- Checked key fields for missing and NULL values.
- Investigated missing values in the `amount` column.
- Confirmed 7,795 records where `amount` was SQL `NULL`.
- Distinguished true SQL `NULL` values from blank or empty-string values to avoid overstating missing-data counts.
- Checked the dataset for duplicate records and investigated the duplicate results before cleaning.
- Validated important order and shipping fields, including `order_id`, `ship_city`, `ship_state`, and `ship_country`.
- Identified 33 records with missing shipping-location information.
- Reviewed categorical fields for inconsistent formatting, whitespace, and standardization issues.
- Used the profiling results to determine the cleaning operations required before business analysis.

## Data Quality Findings

### Missing Revenue Values

The `amount` field contained missing values. Initial checks using broader missing-value conditions produced a higher count, while validation using `IS NULL` confirmed 7,795 true SQL NULL values.

This distinction was important because SQL NULL values and blank text values represent different data conditions and should not automatically be treated as identical.

### Missing Shipping Information

A total of 33 records were identified with missing shipping-location information across fields such as `ship_city`, `ship_state`, and `ship_country`.

These records were retained rather than deleted because missing geographic information did not necessarily invalidate the remaining transaction data.

### Duplicate Investigation

Potential duplicate records were identified during validation and reviewed before any removal decision was made.

Duplicates were not automatically deleted because repeated values or order-related records do not necessarily represent erroneous duplicate transactions. The investigation emphasized validating the business meaning of records before modifying the dataset.

### Formatting and Consistency

Text-based fields were reviewed for leading/trailing whitespace and inconsistent values. Geographic fields, particularly state and city information, required additional attention before aggregation and reporting.

## Challenges & Decisions

- Missing values required careful differentiation between SQL `NULL`, blank strings, and other representations of missing data.
- Records with missing shipping information were retained because deleting an entire transaction solely due to incomplete geographic information could unnecessarily remove otherwise useful sales data.
- Potential duplicates were investigated rather than automatically removed.
- Data-quality decisions were based on the intended analytical use of each field rather than applying blanket deletion rules.

## Lessons Learned

- Data validation should be completed before cleaning so that transformations are based on documented evidence.
- SQL `NULL` values and blank strings must be evaluated separately when profiling missing data.
- Not every incomplete record should be deleted; the importance of the missing field to the analysis should guide the decision.
- Duplicate detection does not automatically justify duplicate removal.
- Documenting data-quality findings and cleaning rationale improves the transparency and reproducibility of an analytics project.

---

# Session 6 – Data Cleaning

## Objectives

- Create a clean analytical table from the validated staging data.
- Standardize text and geographic fields where appropriate.
- Handle missing and inconsistent values without unnecessarily removing valid transactions.
- Preserve a clear separation between the original staging data and the cleaned dataset used for analysis.

## Completed

- Created the `clean_amazon_sales` table from the validated staging data.
- Used `TRIM()` on relevant text fields to remove leading and trailing whitespace.
- Standardized shipping-state values to improve consistency in geographic analysis.
- Applied uppercase formatting and value mappings where necessary to consolidate inconsistent state names.
- Reviewed shipping-city values for inconsistencies and formatting issues.
- Applied trimming to city values while intentionally avoiding extensive manual standardization of every city.
- Preserved missing shipping-location values as SQL `NULL` rather than replacing them with misleading text values.
- Retained records with missing geographic information when the remaining transaction data was still useful.
- Preserved records with missing `amount` values rather than assigning artificial revenue values.
- Verified the cleaned table before using it for subsequent business analysis.
- Established `clean_amazon_sales` as the primary analytical table for downstream SQL analysis and Power BI reporting.

## Key Cleaning Decisions

### Text Standardization

Leading and trailing whitespace was removed from relevant text columns using `TRIM()`.

This prevented visually identical values with hidden whitespace from being treated as separate categories during grouping and aggregation.

### Shipping-State Standardization

State values were standardized to improve the accuracy of geographic analysis.

Formatting inconsistencies were addressed using uppercase conversion and targeted mappings where appropriate so that equivalent state values would aggregate together.

### Shipping-City Treatment

The city field contained a large number of unique values and potential spelling or formatting variations.

Rather than manually standardizing every city value, the project applied whitespace cleaning and focused analytical attention on the most significant cities.

This approach avoided introducing uncertain assumptions into the data while still supporting meaningful city-level analysis.

### Missing Geographic Information

Records with missing `ship_city`, `ship_state`, or `ship_country` information were retained when the remaining transaction information was valid.

The missing geographic values remained SQL `NULL` rather than being replaced with the literal text `"NULL"` or an invented location.

### Missing Amount Values

Missing `amount` values were not replaced with zero because a missing revenue value does not necessarily mean that the transaction generated zero revenue.

These values were preserved as `NULL`, allowing SQL aggregation functions and subsequent analysis to handle them appropriately without introducing artificial revenue values.

## Challenges & Decisions

- Geographic standardization required balancing data consistency against the risk of making unsupported assumptions.
- State values could be standardized using targeted rules, while the much larger number of city values made comprehensive manual mapping impractical.
- Missing values were handled according to their business meaning rather than applying a single rule across every column.
- Records were not automatically removed simply because one field was incomplete.
- Cleaning transformations were performed in a separate analytical table so the staging data remained available for validation and comparison.

## Lessons Learned

- Data cleaning should improve consistency without changing the underlying business meaning of the data.
- `TRIM()` is a simple but important transformation because hidden whitespace can distort grouping and aggregation results.
- Standardization should be targeted and defensible rather than performed simply for the sake of making every value appear uniform.
- SQL `NULL` should be preserved when a value is genuinely unknown instead of replacing it with zero or the text `"NULL"`.
- Maintaining separate staging and cleaned tables provides traceability and makes data transformations easier to validate.
- Cleaning decisions and their rationale are as important to document as the SQL transformations themselves.

---

# Session 7 – SQL Business Analysis

## Objectives

- Use the cleaned Amazon sales data to answer the project's business questions.
- Calculate core sales KPIs using SQL.
- Analyze revenue performance across products, locations, order statuses, and fulfillment dimensions.
- Translate SQL query results into findings suitable for business reporting and Power BI visualization.

## Completed

- Used `clean_amazon_sales` as the primary table for business analysis.
- Developed and executed the SQL analysis contained in `07_Business_Analysis.sql`.
- Calculated core KPIs, including total revenue, total orders, units sold, and average order value.
- Analyzed revenue performance by product category.
- Analyzed revenue by product style to identify the strongest individual products.
- Evaluated geographic sales performance by state and city.
- Analyzed revenue across order-status categories.
- Evaluated revenue associated with different fulfillment methods.
- Examined shipping-related performance where the available data supported meaningful analysis.
- Calculated revenue contribution percentages to provide context beyond absolute revenue values.
- Ranked categories, styles, and geographic markets to identify leading contributors.
- Used SQL findings to determine which metrics and dimensions were most useful for the Power BI dashboard.
- Documented analytical findings for later translation into business insights and recommendations.

## Key Analytical Findings

### Overall Sales Performance

The analysis established the project's core sales KPIs:

- Total Revenue: approximately ₹78.59M
- Total Orders: approximately 120K
- Units Sold: approximately 117K
- Average Order Value: approximately ₹695.33

These metrics provided the high-level performance indicators later displayed as KPI cards in Power BI.

### Product Category Performance

Product-category analysis showed that revenue was highly concentrated in a small number of categories.

SET generated approximately ₹39.2M in revenue, followed by KURTA at approximately ₹21.3M and Western Dress at approximately ₹11.2M.

Because the dataset contained fewer than ten meaningful product categories, all categories were retained for the final dashboard rather than applying an unnecessary Top 10 restriction.

### Product Style Performance

Revenue was also analyzed at the individual product-style level.

JNE3797 was the highest-revenue style at approximately ₹2.9M, followed by J0230 at approximately ₹1.9M.

Because the dataset contained many styles, a Top 10 ranking was appropriate for communicating the strongest performers.

### Geographic Performance

State-level analysis identified Maharashtra as the highest-revenue state at approximately ₹13.3M, followed by Karnataka at approximately ₹10.5M.

Additional analysis was performed at the city level to understand geographic revenue distribution.

The large number of geographic values reinforced the decision to prioritize the strongest markets in the final presentation.

### Fulfillment Performance

Revenue analysis showed that Amazon-managed fulfillment accounted for the majority of revenue.

Approximately ₹54.32M, or 69.12% of total revenue, was associated with Amazon fulfillment, compared with approximately ₹24.27M, or 30.88%, associated with Merchant fulfillment.

### Order Status Analysis

Revenue was analyzed across order-status categories.

The analysis revealed that some cancelled orders were still associated with values in the `amount` field.

This raised an important analytical consideration: summing the source `amount` column represents the revenue value recorded in the dataset, but it should not automatically be interpreted as finalized or recognized revenue without a clearly defined business rule for cancellations and returns.

## Analytical Decisions

### Revenue Percentage Calculations

Absolute revenue values were supplemented with percentage-of-total calculations where useful.

This made it possible to evaluate not only which categories or fulfillment methods generated the most revenue, but also how much they contributed to overall sales.

### Shipping Analysis

Shipping-service analysis was evaluated during SQL analysis.

A units-sold analysis by shipping method was not retained because quantity values, including zero quantities, reduced the usefulness of that comparison.

The analysis was therefore limited to metrics that could be interpreted more reliably, such as orders and revenue.

### Dashboard Visual Selection

Not every SQL analysis was converted into a Power BI visual.

The SQL layer was intentionally more comprehensive than the final dashboard. Visuals were selected based on business relevance, interpretability, and available dashboard space rather than displaying every metric simply because it had been calculated.

## Challenges & Decisions

- Analytical queries had to distinguish between technically available metrics and metrics that were meaningful enough for business reporting.
- Cancelled orders containing revenue amounts demonstrated that source-system fields require business interpretation before being treated as accounting measures.
- Some dimensions contained too many values to present effectively without ranking or filtering.
- Revenue percentages were added to complement absolute values and provide clearer context.
- Less informative analyses were intentionally excluded from the final dashboard to prevent visual overload.

## Lessons Learned

- SQL business analysis should be driven by business questions rather than by the number of available columns.
- A comprehensive analytical layer does not require every result to appear on the final dashboard.
- Ranking and percentage-of-total calculations can make large categorical analyses easier to interpret.
- Business definitions are essential when interpreting measures such as revenue, cancellations, returns, and units sold.
- Analytical findings should be validated before being translated into dashboard KPIs and visuals.
- Effective business intelligence requires both technical analysis and judgment about which findings are important enough to communicate.

---

# Session 8 – Power BI Integration & Data Validation

## Objectives

- Connect Power BI Desktop to the MySQL analytical database.
- Import the cleaned sales data into the reporting environment.
- Validate the imported data before building dashboard visuals.
- Create and verify the DAX measures required for the dashboard.
- Ensure consistency between SQL results and Power BI calculations.

## Completed

- Installed and configured the required MySQL connectivity components for Power BI Desktop.
- Resolved 32-bit and 64-bit connector/ODBC configuration issues encountered during setup.
- Configured the database connection and successfully connected Power BI Desktop to the MySQL database.
- Imported the cleaned Amazon sales data into Power BI.
- Opened Power Query to inspect the imported dataset before beginning dashboard development.
- Enabled Power Query column quality, column distribution, and column profile features to validate the data.
- Reviewed column data types and confirmed that important fields were interpreted appropriately.
- Compared Power Query data-quality observations with the issues previously identified during SQL validation.
- Confirmed that the major cleaning operations had already been completed upstream in SQL.
- Avoided applying unnecessary duplicate cleaning transformations in Power Query.
- Created DAX measures for the primary dashboard KPIs.
- Validated Power BI KPI calculations against the corresponding SQL results.
- Investigated and corrected an initial discrepancy in the Average Order Value calculation.
- Confirmed the final Average Order Value of approximately ₹695.33.
- Verified the core KPI values before using them in the dashboard.

## Data Architecture Decision

The project intentionally separated data preparation from reporting.

SQL was used as the primary environment for:

- Data loading
- Data validation
- Data profiling
- Data cleaning
- Business analysis

Power BI was primarily used for:

- Final data validation
- DAX measures
- Interactive filtering
- Data visualization
- Dashboard development

This avoided performing the same cleaning operations in multiple tools and created a clearer separation between the data-processing and reporting layers.

## Power Query Validation

Power Query was used as a validation checkpoint rather than as the primary cleaning environment.

Column quality, distribution, and profiling features were reviewed to confirm that:

- Data types were appropriate for reporting.
- Previously identified missing values were still represented as expected.
- The cleaned SQL table was loading correctly.
- No additional Power Query transformations were required solely for the sake of demonstrating Power Query usage.

The decision not to introduce unnecessary transformations helped preserve consistency between the SQL analytical dataset and the Power BI reporting model.

## DAX KPI Validation

The primary Power BI measures were validated against SQL calculations before dashboard development continued.

The final dashboard KPIs were:

- Total Revenue: approximately ₹78.59M
- Units Sold: approximately 117K
- Total Orders: approximately 120K
- Average Order Value: approximately ₹695.33

### Average Order Value Validation

An initial discrepancy was identified between the SQL Average Order Value result and the Power BI calculation.

Rather than accepting the Power BI value, the calculation logic was reviewed and corrected.

The final DAX result was validated against the SQL result, producing an Average Order Value of approximately ₹695.33.

This cross-validation increased confidence that the dashboard KPIs reflected the intended business definitions.

## Challenges & Decisions

- Establishing the Power BI-to-MySQL connection required troubleshooting connector and ODBC configuration.
- Data-quality checks were repeated at the reporting layer to verify that the correct analytical table had been imported.
- Power Query transformations were intentionally kept minimal because the required cleaning had already been performed in SQL.
- KPI discrepancies were investigated rather than assuming either SQL or Power BI was automatically correct.
- SQL results were used as a validation reference when developing DAX measures.

## Lessons Learned

- Connecting analytical tools to databases can require troubleshooting beyond simply entering connection credentials.
- Data should be validated again when it moves between systems, even when it has already been cleaned upstream.
- Power Query does not need to perform transformations when the source data has already been appropriately prepared.
- Avoiding unnecessary transformations reduces duplication and makes the analytical workflow easier to maintain.
- DAX measures should be validated against independently calculated SQL results whenever possible.
- Cross-tool validation is an important quality-control step in business intelligence development.

---

# Session 9 – Power BI Dashboard Development & Refinement

## Objectives

- Build an interactive Power BI dashboard from the validated analytical dataset.
- Present the most important sales KPIs and business dimensions clearly.
- Select visuals based on business value rather than displaying every SQL analysis.
- Improve dashboard usability through filtering, ranking, formatting, and layout refinement.
- Validate unusual visual patterns before interpreting them as business trends.

## Completed

- Created KPI cards for:
  - Total Revenue
  - Units Sold
  - Total Orders
  - Average Order Value
- Created an interactive Month slicer for time-based analysis.
- Added Product Category and State slicers to support product and geographic filtering.
- Built a Monthly Revenue Trend visual.
- Built Revenue by Product Category.
- Built Revenue by Product Style.
- Built Revenue by State.
- Built Revenue by Fulfillment Method.
- Evaluated additional visuals, including Customer Segment and Shipping Service.
- Applied Top 10 filtering where appropriate.
- Refined chart titles to clearly communicate ranking and analytical purpose.
- Improved visual spacing, alignment, labels, legends, and overall dashboard layout.
- Removed lower-value visuals to prevent dashboard overcrowding.
- Investigated an unusual March revenue value before interpreting the monthly trend.
- Verified the dataset's date coverage using SQL.
- Excluded the incomplete March period from the Monthly Revenue Trend while retaining the underlying March transactions in the dataset and overall analysis.
- Recovered the Power BI dashboard after Power BI Desktop was closed and the saved report initially reopened without the expected visuals.
- Reconnected and refreshed the recovered report against the MySQL analytical table.
- Verified that the complete dashboard and underlying data model were successfully restored.
- Saved the recovered and finalized Power BI report.

## Final Dashboard KPIs

The final dashboard presents four primary performance indicators:

- Total Revenue: approximately ₹78.59M
- Units Sold: approximately 117K
- Total Orders: approximately 120K
- Average Order Value: approximately ₹695.33

These KPIs provide a concise summary of overall sales performance before users explore individual business dimensions.

## Final Dashboard Visuals

### Monthly Revenue Trend

The monthly trend visual was retained to show changes in revenue over time.

Initial visualization showed an extreme increase between March and April. Rather than interpreting this immediately as business growth, the underlying date coverage was investigated.

SQL validation confirmed that the dataset covers:

- Earliest transaction date: March 31, 2022
- Latest transaction date: June 29, 2022

Because March contains only one day of transactions, it was excluded from the Monthly Revenue Trend visual to avoid creating a misleading month-over-month comparison.

The final comparable trend shows approximately:

- April: ₹28.8M
- May: ₹26.2M
- June: ₹23.4M

This indicates declining revenue across the available comparable monthly periods.

March transactions were not deleted from the dataset and remain included in overall reporting where appropriate.

June contains 29 days and is therefore nearly complete, although this limitation should still be considered when interpreting the trend.

### Revenue by Product Category

All meaningful product categories were displayed because the dataset contained only nine categories.

A Top 10 filter was considered but ultimately removed because applying a Top 10 filter to a dataset containing fewer than ten categories would provide no analytical benefit.

The visual was therefore titled:

`Revenue by Product Category`

### Top 10 Product Styles by Revenue

The product-style dimension contained many values, making ranking necessary for clear presentation.

A Top 10 filter based on Total Revenue was applied.

The chart title was updated to:

`Top 10 Product Styles by Revenue`

This clearly communicates that the visual intentionally displays only the strongest-performing styles.

### Top 10 States by Revenue

Because the geographic dimension contained many states, the State visual was filtered to the Top 10 states by Total Revenue.

The chart title was updated to:

`Top 10 States by Revenue`

This allowed the dashboard to focus on the most significant geographic markets without overcrowding the visual.

### Revenue by Fulfillment Method

The Fulfillment Method visual was retained because both fulfillment methods represented meaningful portions of revenue:

- Amazon: approximately ₹54.32M (69.12%)
- Merchant: approximately ₹24.27M (30.88%)

The visual added an operational dimension to the dashboard alongside the product, geographic, and time-based analyses.

## Visuals Removed During Refinement

### Customer Segment

A Customer Segment visual was initially included.

The analysis showed approximately:

- B2C: 99.25%
- B2B: 0.75%

Because the distribution was overwhelmingly concentrated in one segment, the visual provided limited analytical value relative to the dashboard space it occupied.

The chart was therefore removed from the final dashboard.

The underlying finding can still be documented as part of the broader analysis without requiring a permanent dashboard visual.

### Shipping Service

Revenue by Shipping Service was also evaluated.

Although the metric was valid, it provided less incremental business value than the other selected visuals and competed for limited dashboard space.

Revenue by Fulfillment Method was retained instead because it provided a stronger operational perspective.

The Shipping Service visual was removed from the final dashboard while the underlying SQL analysis was preserved.

## Dashboard Design Decisions

The final dashboard was intentionally designed around a small number of high-value questions:

- What is the overall sales performance?
- How is revenue changing over time?
- Which product categories generate the most revenue?
- Which individual product styles perform best?
- Which geographic markets generate the most revenue?
- How is revenue distributed across fulfillment methods?

The final dashboard therefore follows the analytical flow:

`Overall Performance → Time → Products → Geography → Operations`

This structure was preferred over creating a visual for every SQL query.

## Interactive Filtering

Three primary slicers were retained:

- Product Category
- State
- Month

These dimensions allow users to interactively explore sales performance without overwhelming the dashboard with excessive filtering options.

Slicer headings were renamed from database-oriented field names to user-friendly business labels.

## Dashboard Formatting

Final formatting improvements included:

- Aligning the four KPI cards into a consistent horizontal row.
- Improving spacing between dashboard elements.
- Standardizing chart titles.
- Clearly identifying Top 10 visuals in their titles.
- Adding revenue data labels to the Monthly Revenue Trend.
- Improving Fulfillment Method labels to display both revenue and percentage contribution.
- Removing unnecessary legend headings.
- Renaming slicer headings for improved readability.
- Maintaining a consistent visual hierarchy across the dashboard.

## Dashboard Recovery & Troubleshooting

During the final development stage, Power BI Desktop was closed and the initially reopened report did not display the completed dashboard.

Power BI Auto Recovery was used to locate and open the most recent recovered version.

The recovered report initially contained the dashboard structure but displayed blank visuals and incomplete data.

Troubleshooting included:

- Saving the recovered report as a separate file before making additional changes.
- Reviewing Data Source Settings.
- Confirming the connection to the local `amazon_ecommerce_db` MySQL database.
- Opening Power Query and verifying that the Power BI query was sourcing the `clean_amazon_sales` table.
- Confirming that Power Query could successfully retrieve the underlying records.
- Identifying that the Power BI data model initially contained zero loaded rows.
- Refreshing the model and calculated objects.
- Successfully restoring the underlying data and all dashboard visuals.
- Revalidating the dashboard after recovery.

This recovery process prevented unnecessary rebuilding of the dashboard and reinforced the importance of saving report files and validating the data model when troubleshooting blank Power BI visuals.

## Challenges & Decisions

- Limited dashboard space required prioritizing the most meaningful visuals.
- Not every SQL analysis justified a permanent dashboard visual.
- Top 10 filtering was applied only where the number of dimension values made ranking useful.
- An unusual monthly pattern was investigated before being interpreted as a business trend.
- Partial-period data required visual-level filtering rather than deleting valid source records.
- Dashboard recovery required separating report-layout problems from data-model and data-source problems.
- Formatting decisions focused on readability and business communication rather than adding unnecessary visual complexity.

## Lessons Learned

- A strong dashboard does not need to display every available metric.
- Visual selection should be based on business relevance, clarity, and decision-making value.
- Top N filtering should be applied intentionally rather than automatically.
- Unexpected trends should be investigated against the underlying data before conclusions are drawn.
- Partial reporting periods can significantly distort time-series comparisons.
- Visual-level filtering can address presentation issues without altering valid underlying data.
- SQL validation remains useful even during dashboard development.
- Dashboard design requires both analytical judgment and visual prioritization.
- Troubleshooting Power BI requires distinguishing between the report layer, data model, Power Query, and underlying data source.
- Saving recoverable versions and validating the source connection can prevent unnecessary rework.

---

# Session 10 – Business Insights & Recommendations

## Objectives

- Consolidate the strongest findings from the SQL analysis and Power BI dashboard.
- Translate analytical results into meaningful business insights.
- Develop practical recommendations based on the observed sales patterns.
- Document important limitations that affect interpretation of the results.
- Create a dedicated Business Insights & Recommendations document for the completed analysis.

## Completed

- Reviewed the completed SQL analysis and finalized Power BI dashboard.
- Selected the strongest findings rather than treating every SQL query as a separate business insight.
- Organized the final insights using the structure:
  - Key Finding
  - Business Impact
  - Recommendation
- Developed six primary business insights covering:
  - Product category performance
  - Product style performance
  - Geographic performance
  - Monthly revenue trends
  - Fulfillment method performance
  - Order status and data-quality considerations
- Created `06_Business_Insights_and_Recommendations.md` in the Documentation folder.
- Added an executive summary of the overall analytical findings.
- Documented important data and reporting limitations alongside the recommendations.
- Ensured that recommendations were supported by observed data rather than unsupported assumptions.

## Final Business Insights

### Product Category Performance

SET was the strongest product category, generating approximately ₹39.2M in revenue, followed by KURTA at approximately ₹21.3M and Western Dress at approximately ₹11.2M.

This demonstrated significant revenue concentration among a small number of product categories.

The analysis recommended prioritizing inventory availability, merchandising, and promotional planning for high-performing categories while evaluating opportunities to improve or optimize lower-performing categories.

### Product Style Performance

JNE3797 was the highest-revenue individual product style at approximately ₹2.9M, followed by J0230 at approximately ₹1.9M.

The analysis recommended maintaining adequate availability of consistently high-performing styles and investigating the characteristics contributing to their stronger performance.

### Geographic Performance

Maharashtra generated approximately ₹13.3M in revenue, followed by Karnataka at approximately ₹10.5M.

The results showed that several states represent particularly important geographic markets.

The analysis recommended prioritizing inventory positioning, fulfillment capacity, and targeted marketing in high-performing states while investigating opportunities for growth in lower-performing regions.

### Monthly Revenue Trend

Comparable monthly revenue decreased from approximately ₹28.8M in April to ₹26.2M in May and ₹23.4M in June.

This represented an approximate 18.8% decline between April and June.

The analysis recommended monitoring performance over a longer reporting period and investigating potential drivers such as order volume, product demand, cancellations, pricing, and seasonal effects before drawing broader conclusions.

March was excluded from the comparative monthly trend because the dataset begins on March 31, 2022 and therefore contains only one day of March transactions.

June ends on June 29, 2022 and is nearly complete, although this limitation was retained when interpreting the trend.

### Fulfillment Method Performance

Amazon-managed fulfillment accounted for approximately ₹54.32M, or 69.12% of revenue, compared with approximately ₹24.27M, or 30.88%, associated with Merchant fulfillment.

The analysis recommended further comparison of fulfillment methods using measures such as order volume, cancellations, returns, delivery performance, and average order value before concluding that one method is operationally superior.

### Order Status & Data Quality

The analysis identified cancelled orders that were still associated with values in the `amount` field.

This demonstrated that the source revenue field should not automatically be interpreted as finalized or recognized revenue without a clearly defined business rule.

The analysis recommended distinguishing gross order value from realized revenue in future reporting and separately monitoring cancelled and returned transactions.

## Business Interpretation Approach

The project intentionally separated analytical findings from business recommendations.

A high-performing category, state, style, or fulfillment method was not automatically assumed to be more profitable or operationally superior.

Recommendations were therefore framed as evidence-based actions or areas for further investigation rather than unsupported causal conclusions.

This approach helped ensure that the final business interpretation remained consistent with the limitations of the available dataset.

## Key Limitations Documented

- The dataset covers only March 31 through June 29, 2022.
- March contains only one day of transactions and cannot be fairly compared with complete months.
- June contains 29 days and is nearly complete but is technically still a partial month.
- Missing values exist in important fields, including `amount` and shipping-location information.
- Some cancelled orders contain recorded revenue amounts.
- The dataset alone does not establish whether the `amount` field represents gross order value or finalized recognized revenue in every order-status scenario.
- Observed relationships should not automatically be interpreted as causal relationships.

## Challenges & Decisions

- The final insights had to be selective rather than simply restating every SQL result.
- Recommendations needed to remain within what the available data could reasonably support.
- Revenue-related findings required careful wording because of cancellation and order-status considerations.
- Monthly performance required disclosure of the dataset's partial-period coverage.
- Operational differences, such as Amazon versus Merchant fulfillment, were treated as areas for further investigation rather than proof of superior performance.

## Lessons Learned

- Business analysis requires translating technical results into information that supports decision-making.
- A useful insight should explain not only what happened, but why the finding matters to the business.
- Recommendations should be supported by evidence and should not claim more than the data can demonstrate.
- Analytical limitations should be communicated alongside findings rather than hidden from the final presentation.
- Data visualization, SQL analysis, and business interpretation are complementary parts of the same analytical workflow.
- A small number of well-supported insights can be more valuable than a large collection of descriptive statistics.

---


# Current Status

Completed:

- Project setup and repository structure
- Dataset understanding and documentation
- Business-question development
- MySQL database development and data loading
- SQL data validation and profiling
- SQL data cleaning
- SQL business analysis
- MySQL-to-Power BI integration
- Power BI data and KPI validation
- Interactive dashboard development
- Dashboard refinement and finalization
- Business insights and recommendations
- Project journal documentation

Current phase:

- Final README development
- Repository cleanup and final review
- Git commit and GitHub publication

The analytical and dashboard development phases of the Amazon E-Commerce Sales Analysis project are complete.