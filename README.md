# E-Commerce Catalog & Performance Optimization Strategy

##  Project Overview
This project focuses on translating raw PostgreSQL database queries into high-impact corporate retail strategy. By evaluating e-commerce performance metrics across multiple categories (Footwear, Fashion, Accessories, Electronics) using a real-world dataset of over 2,000 products, this analysis isolates dead stock risks, critical vendor supply chain bottlenecks, and severe pricing anomalies to protect profit margins and improve user experience.

###  Tech Stack & Tools Used
* **Database / Query Engine:** PostgreSQL
* **Data Visualization & Export:** DBeaver (SQL Query Output Tables)
* **Presentation & Synthesis:** Gamma App
* **Version Control:** GitHub

---

##  Core Business Problems & Analytical Framework
The project breaks down 15 major business inquiries grouped into 4 strategic retail pillars:

### 1. Supply Chain Health & Revenue Leakage
* **The Problem:** Tracking high-demand products with extensive consumer review histories that are completely out of stock.
* **Key Finding:** Fast-fashion and athletic apparel giants (**Zara at 42.31%** and **Adidas at 40.89%**) have over 40% of their total catalog completely unavailable, causing severe conversion drops and revenue leaks.

### 2. The "Discount Trap" vs. Margin Erosion
* **The Problem:** Isolating heavily discounted items that fail to spark customer satisfaction, and tracking massive absolute margin drops.
* **Key Finding:** Multiple premium items maintain low ratings (around 3.2) despite massive price cuts, proving that heavy discounts cannot compensate for underlying product defects. Furthermore, high-end hardware (e.g., HP Pavilion, Dell Laptops) took absolute price cuts of up to ₹55,869 to stimulate sales velocity.

### 3. Catalog Integrity & Structural Anomalies
* **The Problem:** Detecting manual seller listing errors or data noise where budget-friendly brands are erroneously marked up, or identifying tracking errors.
* **The Brand Paradox:** Analyzing instances where the identical core product variant name scored both a perfect 5.0 and a low 3.2 rating simultaneously, pointing to localized vendor fulfillment or batch quality issues rather than macro brand failure.

---

##  Repository Structure
To explore the moving parts of this project, navigate through the folders above:
* `/data`: Holds the raw, real-world CSV dataset utilized for the analysis.
* `/sql_queries`: Contains the complete, production-ready PostgreSQL script files used to query the database.
* `/visualizations`: Contains the verified query data output tables and charts exported from DBeaver (Queries 1–15).
* `/documentation`: Holds the complete executive deck synthesized for stakeholders via Gamma.

---

##  Key Strategic Recommendations
1. **Implement Supplier SLA Caps:** Enforce automated ranking or platform visibility penalties for key brands (Zara, Adidas) whose out-of-stock ratios cross a 30% operational threshold.
2. **Deploy Variant-Level Filters:** Isolate merchant and condition IDs (New vs. Refurbished/Renewed) to ensure low-performing independent sellers do not degrade core brand equities (e.g., Apple, Samsung).
3. **Transition to Clearance Badging:** Shift low-rated, high-discount items out of main promotional carousels into a dedicated "As-Is Clearance" section to protect platform reputation.

---
*Developed as part of my advanced business intelligence and data analytics portfolio.*
