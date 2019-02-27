---
title: Create an Application
description: Create an application to use with the APIs
navigation_weight: 1
---

# Create an Application

To work with the Vonage Business Cloud APIs, you need to create an Application.

> Note: To avoid confusion, "Application" in this context refers to a logical grouping of APIs. The application you are building to consume these APIs will be referred to as "application".

## Create a new Application

1. Sign into [Vonage UC Extend](https://developer.entva0.qa.vonagenetworks.net/store/) using either your Vonage Business Cloud or Vonage Enterprise Credentials and select "Other" from the Platform drop down list.

2. Select "My Applications" from the left-hand navigation menu.

3. Click "Add Application" at the top of the page.

4. In the Add Application dialog, enter a name and optionally a description for your application, so that you can locate it easily later. You can limit the maximum number of requests for each access token in the "Per Token Quota" dropdown if you want to restrict the number of requests. By default it is "Unlimited". Then click the "Add" button.

    ![Screenshot showing the Add Application dialog](/assets/images/vbc/create-application.png)

Now that you have created your Application, you need to [set up authentication](/vonage-business-cloud/account/guides/authentication) for it to use the Account API.
