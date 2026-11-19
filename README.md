# SQL Cleaning exercice
Customer Orders Data Cleaning – SQL Project

**Project Overview**

This project focuses on cleaning and standardizing a customer orders dataset using Google BigQuery and SQL.

Following a practical SQL tutorial on YouTube, I explored common data-cleaning techniques to improve data consistency, handle missing values, standardize inconsistent entries, and remove duplicate records.

The objective was to transform raw customer order data into a cleaner and more structured dataset that could be used for further analysis.

**Project Objectives**

The project covers the following data-cleaning operations:

Data exploration: Inspecting the original dataset and reviewing its structure.

Order status standardization: Grouping inconsistent order status values into standardized categories.

Product name standardization: Normalizing product names to ensure consistent product identification.

Quantity cleaning: Converting text-based quantities (e.g., "two") into numerical values.

Customer name cleaning: Using proper capitalization to improve consistency.

Duplicate removal: Identifying and removing duplicate orders based on customer email and product name.

Date standardization: Converting dates stored in different formats into a consistent DATE format.

Final dataset creation: Combining the cleaning operations into a single SQL query using Common Table Expressions (CTEs).

**Tools & Technologies**

Google BigQuery – Cloud-based data warehouse used to query and clean the dataset.

SQL (Standard SQL) – Used for data exploration, transformation, standardization, and deduplication.

**Key Learnings**

Through this project, I gained practical experience in:

Writing SQL queries to explore and understand raw datasets.

Handling inconsistent text values using conditional logic.

Converting data types and standardizing date formats.

Identifying duplicates using window functions.

Structuring complex queries using multiple CTEs.

Combining individual cleaning operations into a final data-cleaning workflow.

This project helped me strengthen my SQL fundamentals and understand the importance of data quality before performing data analysis.

**Learning Resources** 

This project was inspired by the following YouTube tutorial:

SQL Data Cleaning Tutorial (https://www.youtube.com/watch?v=eOlHqTfWi6k)

The SQL queries were implemented and adapted as part of my hands-on practice with Google BigQuery.
