---
title: Download report
description: Download a successful report
navigation_weight: 3
---

# Download report

Once a report has been successfully created you can call the [check report status](/reporting/building-blocks/check-report-status) endpoint, which will return a JSON payload containing a `url` field. This is the URL that you will use to download your report as a `zip` file.

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`REPORT_URL` |	The URL of the report to download. Returned in the [check report status](/reporting/building-blocks/check-report-status) response

```building_blocks
source: '_examples/reporting/download-report'
```
