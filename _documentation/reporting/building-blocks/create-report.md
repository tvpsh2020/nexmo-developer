---
title: Create a report
description: How to create a new report
navigation_weight: 1
---

# Create report

Before you can download a report, you must [create a report](/api/reports#createReport) by specifying which product you're interested in, plus any additional filters. For a full list of available products and filters, see the [reports API reference](/api/reports#createReport).

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`REPORT_PRODUCT` |	The product you'd like to generate a report for. Must be one of: `SMS`, `VOICE-CALL`, `VERIFY-API`, `NUMBER-INSIGHT` or `VERIFY-SDK`

```building_blocks
source: '_examples/reporting/create-report'
```
