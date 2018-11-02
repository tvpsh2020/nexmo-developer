---
title: Check report status
description: Check if a report has succeeded, failed or is still running
navigation_weight: 2
---

# Check report status

Creating a report may take a short amount of time, so you need to check if it's available periodically. Once the report has successfully been produced, the request shown below will return a `request_status` of `"SUCCESS"` and provide a URL in the `url` field that you can use to [download the report](/reporting/building-blocks/download-report)

## Example

Replace the following variables in the example code:

Key |	Description
-- | --
`REPORT_ID` |	The ID of the report you want to check. Returned in the [create report](/reporting/building-blocks/create-report) response

```building_blocks
source: '_examples/reporting/check-report-status'
```
