# Databricks Genie + LLM Use Cases

## 1) Executive KPI Q&A
- Question: "Which segment has highest failed ratio this week?"
- Data source: `v_customer_360`, `v_risk_features`
- Value: fast decision support for analytics leadership.

## 2) Product Funnel Diagnostics
- Question: "Do failed transactions spike by customer segment?"
- Data source: gold KPIs + event-level silver table
- Value: identify customer friction and optimize flows.

## 3) Risk Monitoring Assistant
- Question: "Which customers show unusual ticket size + high failure?"
- Data source: `v_risk_features`
- Value: triage candidates for analyst review.

## Guardrails for interview
- Row/column-level security through Unity Catalog.
- PII masking policies before exposing to Genie.
- Prompt templates and approved metric dictionary.
