# OLIST E-Commerce Customer Segmentation

This repository contains a project regarding to Data Warehousing and Analytics in the Cloud. In this project, we demonstrate how to build a Snowflake-backed analytics pipeline, perform data preparation and feature engineering, and apply unsupervised machine-learning techniques (RFM analysis and K-Means clustering) to segment customers of the Brazilian E-Commerce dataset.

---

## Overview

We ingest the Brazilian E-Commerce Public Dataset by Olist into a Snowflake data warehouse, clean and merge eight interrelated tables into a single pandas DataFrame, and then perform unsupervised customer segmentation. Key steps include:

- **Data warehousing**: creating and loading Snowflake tables  
- **Extraction**: connecting via SQLAlchemy in Jupyter Notebook  
- **Cleaning & merging**: deduplicating, handling nulls, and joining tables  
- **Feature engineering**: temporal, ratio-based, customer-level, and order-level metrics  
- **Modeling**: RFM scoring and K-Means clustering to uncover customer segments  

---

## Data Sources

- **Kaggle**: Brazilian E-Commerce Public Dataset by Olist  
  - https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data  